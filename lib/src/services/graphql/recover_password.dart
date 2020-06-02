String recoverPass = r'''query($email: String!) {
    passwordForgotten(email: $email)
}''';