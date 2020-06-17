String saveFCMTokenQuery = r'''
mutation( $fcmTokens: [String], ) {
    updateUserByResident(input: { fcmTokens: $fcmTokens })
}
''';
