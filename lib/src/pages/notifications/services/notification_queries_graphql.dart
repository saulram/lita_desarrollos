String getNotifications = r'''
query {
    notifications {
        _id
        title
        description
        customFields {
            label
            value
        }
        alreadyRead
        redirectTo
        updatedAtFormat
    }
}
''';
String markAsRead =r'''
    mutation($id: ID!) {
    notificationRead(id: $id)
}
    ''';