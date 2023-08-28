import 'package:modbus/modbus.dart' as modbus;
import 'package:logging/logging.dart';


main(List<String> arguments) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time} [${rec.loggerName}]: ${rec.message}');
  });

  var client = modbus.createTcpClient('127.0.0.1',
      port: 502, mode: modbus.ModbusMode.rtu, timeout: Duration(seconds: 5));

  try {
    await client.connect();


    {
      var registers = await client.readHoldingRegisters(0x0001,25);
      for (int i = 0; i < registers.length; i++) {
        print("REG_I[${i}]: " + registers.elementAt(i).toString());
      }
    }
  } finally {
    client.close();
  }
}
