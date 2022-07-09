abstract class SudoRPCCall {
  final String version;

  SudoRPCCall(this.version);

  Map<String, dynamic> toJson();
}
