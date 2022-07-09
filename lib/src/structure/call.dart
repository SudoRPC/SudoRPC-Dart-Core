/// @author WMXPY
/// @namespace Structure
/// @description Call

class SudoRPCCall {
  final String version;

  SudoRPCCall(this.version);
}

class SudoRPCCallV1<Metadata, Payload> extends SudoRPCCall {
  final String resource;
  final String identifier;

  final Metadata metadata;
  final Payload payload;

  SudoRPCCallV1({
    required this.resource,
    required this.identifier,
    required this.metadata,
    required this.payload,
  }) : super("1.0");
}
