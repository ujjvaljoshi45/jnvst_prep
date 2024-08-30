class Message {
  String sender;
  String text;
  Message({required this.sender, required this.text});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(sender: json['sender'], text: json['text']);
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'text': text,
      };
}
