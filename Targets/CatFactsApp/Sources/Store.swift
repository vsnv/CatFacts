//
//  Store.swift
//  CatFactsApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import Foundation

final class Store<TState, TEvent, TEffect> {

	// MARK: - Typealias

	typealias Dispatch = (TEvent) -> Void
	typealias Observer = (TState) -> Void
	typealias Update = (_ state: inout TState, _ event: TEvent) -> [TEffect]
	typealias Performer = (TEffect, @escaping Dispatch) -> Void

	// MARK: - Private properties

	public private(set) var state: TState
	private let update: Update
	private let performer: Performer
	private let queue: DispatchQueue
	private var observers = [Observer]()

	// MARK: - Lifecycle

	/// Инициализация
	public init(
		state: TState,
		update: @escaping Update,
		performer: @escaping Performer,
		queue: DispatchQueue
	) {
		self.state = state
		self.update = update
		self.performer = performer
		self.queue = queue
	}

	// MARK: - Public methods

	/// Обновляет стор событием
	/// - Parameter event: Событие для обновления стора
	public func dispatch(_ event: TEvent) {
		queue.async {
			self.innerDispatch(event)
		}
	}

	/// Подписка на обновление стора
	/// - Parameter subscription: кложура для выполнения при обновлении стора
	public func observe(_ subscription: @escaping Observer) {
		observers.append(subscription)
	}

	private func innerDispatch(_ event: TEvent) {
		let commands = update(&state, event)
		observers.forEach { $0(state) }
		commands.forEach { performer($0, dispatch) }
	}
}
