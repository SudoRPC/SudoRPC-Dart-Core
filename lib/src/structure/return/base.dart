abstract class SudoRPCReturn {
  final String version;

  SudoRPCReturn(this.version);

  Map<String, dynamic> toJson();
}
