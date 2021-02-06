class ChatList {
  final String name;
  final String description;
  final String image;

  ChatList({
    this.name,
    this.description,
    this.image,
  });
}

List<ChatList> loadChatListItem = <ChatList>[
  ChatList(
    name: "Khushi",
    description: "Hey! WatsUp",
    image: "images/profile.jpeg",
  ),
  ChatList(
    name: "Mummy",
    description: "Meet me",
    image: "images/profile_two.jpg",
  ),
  ChatList(
    name: "Papa",
    description: "How are you",
    image: "images/profile_three.png",
  ),
  ChatList(
    name: "Babu",
    description: "Getting bored",
    image: "images/profile_four.jpeg",
  ),
  ChatList(
    name: "Gudda",
    description: "call me",
    image: "images/profile_five.png",
  ),
  ChatList(
    name: "Baeu",
    description: "Miss you",
    image: "images/profile_six.jpeg",
  )
];
