enum FirestoreType { get, post, put, delete }

enum AuthenticationType {
  resetPassword,
  phoneNumber,
  signIn,
  signUp,
  anonymous,
  google,
}

enum FirestoreUseCaseType {
  // Users
  getUser,
  postUser,
  putUser,
  deleteUser,
  // Users
  getActivity,
  postActivity,
  deleteActivity,
  puActivity,
  // Products
  getProduct,
  postProduct,
  putProduct,
  deleteProduct,
  // Carts
  getCustomers,
  postCustomers,
  deleteCustomers,
}
