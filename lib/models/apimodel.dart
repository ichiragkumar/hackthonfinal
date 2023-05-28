class ChatCompletion {
  final String id;
  final String object;
  final int created;
  final String model;
  final Map<String, dynamic> usage;
  final List<Map<String, dynamic>> choices;

  ChatCompletion({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  factory ChatCompletion.fromJson(Map<String, dynamic> json) {
    return ChatCompletion(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      usage: json['usage'],
      choices: List<Map<String, dynamic>>.from(json['choices']),
    );
  }
}
