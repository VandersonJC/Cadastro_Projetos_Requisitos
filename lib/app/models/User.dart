class User
{

  User();

  int?     id;
  String? name;


  static List<User> getUsers()
  {
    final List<User> userList = [];
    User user1 = User();
    user1.id = 1;
    user1.name = "Vanderson";
    userList.add(user1);

    User user2 = User();
    user2.id = 1;
    user2.name = "Juca Bala";
    userList.add(user2);

    User user3 = User();
    user3.id = 1;
    user3.name = "Michel Jacson";
    userList.add(user3);

    return userList;
  }

}