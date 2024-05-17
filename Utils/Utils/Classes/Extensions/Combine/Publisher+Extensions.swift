//
//  Publisher+Extensions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 2.10.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine

public extension Publisher {
    func strongSink(receiveCompletion: @escaping (Subscribers.Completion<Self.Failure>) -> Void = { _ in },
                    receiveValue: @escaping (Self.Output) -> Void) {
        var referenceHolder: [AnyCancellable] = []
        
        sink(
            receiveCompletion: { completion in
                _ = referenceHolder
                receiveCompletion(completion)
            },
            receiveValue: receiveValue
        )
        .store(in: &referenceHolder)
    }
    
    @available(*, unavailable, message: "Use handleEvents(...)")
    func rethrowingStrongSink(receiveCompletion: @escaping (Subscribers.Completion<Self.Failure>) -> Void = { _ in },
                              receiveValue: @escaping (Self.Output) -> Void) -> AnyPublisher<Output, Failure> {
        handleEvents(
            receiveOutput: receiveValue,
            receiveCompletion: receiveCompletion
        )
        .eraseToAnyPublisher()
    }
    
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        map { _ in }.eraseToAnyPublisher()
    }
    
    func bind<Binding>(to bindingSubject: Binding) -> AnyCancellable where Binding: Subject,
                                                                           Binding.Output == Output,
                                                                           Binding.Failure == Failure {
        sink(
            receiveCompletion: { [weak bindingSubject] completion in
                bindingSubject?.send(completion: completion)
            },
            receiveValue: { [weak bindingSubject] value in
                bindingSubject?.send(value)
            }
        )
    }
    
    func bind<Binding>(to bindingSubject: Binding) -> AnyCancellable where Binding: Subject,
                                                                           Binding.Output == Output?,
                                                                           Binding.Failure == Failure {
        sink(
            receiveCompletion: { [weak bindingSubject] completion in
                bindingSubject?.send(completion: completion)
            },
            receiveValue: { [weak bindingSubject] value in
                bindingSubject?.send(value)
            }
        )
    }
    
    func bindOutput<Binding>(to bindingSubject: Binding) -> AnyCancellable where Binding: Subject,
                                                                           Binding.Output == Output {
        sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak bindingSubject] value in
                bindingSubject?.send(value)
            }
        )
    }
    
    func bindOutput<Binding>(to bindingSubject: Binding) -> AnyCancellable where Binding: Subject,
                                                                           Binding.Output == Output? {
        sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak bindingSubject] value in
                bindingSubject?.send(value)
            }
        )
    }
    
    func perform(work: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        map {
            work($0)
            return $0
        }
        .eraseToAnyPublisher()
    }
    
    func bind<Binding>(to bindingSubject: Binding,
                       valueTransformer: @escaping (Output) -> Binding.Output) -> AnyCancellable where Binding: Subject,
                                                                                                       Binding.Failure == Failure {
        sink(
            receiveCompletion: { [weak bindingSubject] completion in
                bindingSubject?.send(completion: completion)
            },
            receiveValue: { [weak bindingSubject] value in
                bindingSubject?.send(valueTransformer(value))
            }
        )
    }
}

public extension Publisher where Failure: Error {
    func sink(receiveValue: @escaping (Output) -> Void,
              receiveError: @escaping (Failure) -> Void) -> AnyCancellable {
        sink(
            receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                receiveError(error)
            },
            receiveValue: receiveValue
        )
    }
    
    func strongSink(receiveValue: @escaping (Output) -> Void,
                    receiveError: @escaping (Failure) -> Void) {
        strongSink(
            receiveCompletion: {
                guard case let .failure(error) = $0 else { return }
                receiveError(error)
            }, receiveValue: {
                receiveValue($0)
            }
        )
    }
}

public extension Publisher {
    func weakCapture<WeakObject>(object: WeakObject?, perform: @escaping (WeakObject, Output) -> Void) -> AnyPublisher<Output, Failure> where WeakObject: AnyObject {
        map { [weak object] output -> Output in
            guard let strongObject = object else {
                return output
            }
            
            perform(strongObject, output)
            return output
        }
        .eraseToAnyPublisher()
    }
    
    func weakCapture<WeakObject>(object: WeakObject?,
                                 performAndWait: @escaping (WeakObject, Output, @escaping Closure.Void) -> Void) -> AnyPublisher<Output, Failure> where WeakObject: AnyObject {
        flatMap { [weak object] output -> AnyPublisher<Output, Failure> in
            guard let strongObject = object else { return Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher() }
            
            return Future<Output, Failure> { promise in
                performAndWait(strongObject, output, { promise(.success(output)) })
            }
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher {
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            compactMap compactMapWithStrongObject: @escaping (WeakObject, Output) -> NewOutput) -> AnyPublisher<NewOutput, Failure> where WeakObject: AnyObject {
        compactMap { [weak object] (value: Output) -> NewOutput? in
            guard let unwrappedObject = object else { return nil }
            
            return compactMapWithStrongObject(unwrappedObject, value)
        }
        .eraseToAnyPublisher()
    }
    
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            map mapWithStrongObject: @escaping (WeakObject, Output) -> NewOutput) -> AnyPublisher<NewOutput?, Failure> where WeakObject: AnyObject {
        map { [weak object] (value: Output) -> NewOutput? in
            guard let unwrappedObject = object else { return nil }
            
            return mapWithStrongObject(unwrappedObject, value)
        }
        .eraseToAnyPublisher()
    }
    
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            completeImmediatelyOnNilObject: Bool = true,
                                            flatMap flatMapWithStrongObject: @escaping (WeakObject, Output) -> AnyPublisher<NewOutput, Failure>) -> AnyPublisher<NewOutput, Failure> where WeakObject: AnyObject {
        flatMap { [weak object] (value: Output) -> AnyPublisher<NewOutput, Failure> in
            guard let unwrappedObject = object else {
                return Empty(completeImmediately: completeImmediatelyOnNilObject)
                       .eraseToAnyPublisher()
            }
            
            return flatMapWithStrongObject(unwrappedObject, value)
                   .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == Void {
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            compactMap compactMapWithStrongObject: @escaping (WeakObject) -> NewOutput) -> AnyPublisher<NewOutput, Failure> where WeakObject: AnyObject {
        weakCapture(object: object, compactMap: { strongObject, _ in
            compactMapWithStrongObject(strongObject)
        })
    }
    
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            map mapWithStrongObject: @escaping (WeakObject) -> NewOutput) -> AnyPublisher<NewOutput?, Failure> where WeakObject: AnyObject {
        weakCapture(object: object, map: { strongObject, _ in
            mapWithStrongObject(strongObject)
        })
    }
    
    func weakCapture<NewOutput, WeakObject>(object: WeakObject?,
                                            completeImmediatelyOnNilObject: Bool = true,
                                            flatMap flatMapWithStrongObject: @escaping (WeakObject) -> AnyPublisher<NewOutput, Failure>) -> AnyPublisher<NewOutput, Failure> where WeakObject: AnyObject {
        weakCapture(object: object, completeImmediatelyOnNilObject: completeImmediatelyOnNilObject, flatMap: { strongObject, _ in
            flatMapWithStrongObject(strongObject)
        })
    }
}

public extension Publisher where Output == Void {
    func weakCapture<WeakObject>(object: WeakObject?, perform: @escaping (WeakObject) -> Void) -> AnyPublisher<Output, Failure> where WeakObject: AnyObject {
        map { [weak object] output -> Output in
            guard let strongObject = object else {
                return output
            }
            
            perform(strongObject)
            return output
        }
        .eraseToAnyPublisher()
    }
    
    func weakCapture<WeakObject>(object: WeakObject?, performAndWait: @escaping (WeakObject, @escaping Closure.Void) -> Void) -> AnyPublisher<Output, Failure> where WeakObject: AnyObject {
        flatMap { [weak object] output -> AnyPublisher<Output, Failure> in
            Future<Output, Failure> { promise in
                guard let strongObject = object else { promise(.success(output)); return }
                
                performAndWait(strongObject, { promise(.success(output)) })
            }
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

public extension Publisher where Failure == Never {
    /// * Note:
    /// ```
    /// func bind<Root: NSObject>(to keyPath: KeyPath<Root, Output>, on root: Root) -> AnyCancellable {
    ///     sink { [weak root] value in
    ///         root?.setValue(value, forKey: NSExpression(forKeyPath: keyPath).keyPath)
    ///     }
    /// }
    /// ```
    /// with the following results in fatal error in case output is nil
    /// ```
    /// bind(to: \.image, on: imageView)
    /// bind(to: \.attributedText, on: label)
    /// ```
    /// but plain code works fine:
    /// ```
    /// imageView.setValue(nil, forKey: NSExpression(forKeyPath: keyPath).keyPath)
    /// ```
    /// the following works fine in all cases:
    /// ```
    /// func bind<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
    ///     sink { [weak root] value in
    ///         root?[keyPath: keyPath] = value
    ///     }
    /// }
    /// ```
    /// Although `[weak root]` makes it possible to use `WritableKeyPath<,>`, since `weak var root` is mutable, anyway its more correct to use `ReferenceWritableKeyPath<,>`
    func bind<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root?) -> AnyCancellable {
        sink { [weak root] value in
            root?[keyPath: keyPath] = value
        }
    }
    
    func bind<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output?>, on root: Root?) -> AnyCancellable {
        sink { [weak root] value in
            root?[keyPath: keyPath] = value
        }
    }
}

public extension Publisher {
    func prependOutput<T>(with value: T) -> AnyPublisher<(T, Output), Failure> {
        Just(value).setFailureType(to: Failure.self)
            .combineLatest(self)
            .eraseToAnyPublisher()
    }
    
    func appendOutput<T>(with value: T) -> AnyPublisher<(Output, T), Failure> {
        combineLatest(
            Just(value).setFailureType(to: Failure.self)
        )
        .eraseToAnyPublisher()
    }
}

public extension Publisher {
    func merge<T>(with array: [T]) -> AnyPublisher<Output, Failure> where T: Publisher, T.Output == Output, T.Failure == Failure {
        array.reduce(self.eraseToAnyPublisher(), { result, anotherPublisher in
            result.merge(with: anotherPublisher).eraseToAnyPublisher()
        })
    }
}

public extension Publisher where Output: Sequence {
    func asContinuousPublisher() -> AnyPublisher<Output.Element, Failure> {
        flatMap { output in
            return Empty<Output.Element, Failure>()
                .append(output)
        }
        .eraseToAnyPublisher()
    }
}

public extension Subscribers.Completion {
    var underlyingError: Failure? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }
}

//-------------------------------------------------
// MARK: - AnyCancellable
//-------------------------------------------------

public extension AnyCancellable {
    func store(in property: inout AnyCancellable?) {
        property = self
    }
}
