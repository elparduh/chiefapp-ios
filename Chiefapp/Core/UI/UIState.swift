enum UIState<T> {
    case initial
    case loading
    case success(T)
    case failure(String)
}
