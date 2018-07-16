program client;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ScktComp,
  StdCtrls;

type
  _Client = class 
  socket: TClientSocket; // объект класса TClientSocket для соединения с сервером
  text: string; // сообщение
  procedure connect(); // метод соединения с сервером
  procedure send(); // метод отправки сообщения
  procedure disconnect(); // метод отсоединения от сервера
  end;

procedure _Client.connect();
begin
  socket := TClientSocket.Create(nil); // Инициализируем объект socket объектом класса TClientSocket
  socket.Address := '127.0.0.1'; // Устанавливаем адрес
  socket.Port := 13000; // Устанавливаем порт
  socket.ClientType := ctBlocking; // Установка сокета в режим блокировки
  socket.Open; // Устанавливаем соединение с сервером
  if socket.Active then writeln('Подключение выполнено')
  else
  begin
    writeln('Не удалось подключиться');
    sleep(3000);
    Halt; // Завершение программы
  end;
end;

procedure _Client.send();
begin
  readln(text); // Получаем сообщение в переменную text
  socket.Socket.SendText(text + sLineBreak); // Отправляем сообщение с разделителем строки
end;

procedure _Client.disconnect();
begin
  socket.Free; // Отсоединение от сервера
  writeln('Отключено');
end;


var
  client: _Client;
  ch: string; 

begin
  client := _Client.Create(); // Инициализируем объект client объектом класса _Client
  client.connect(); // Подключаемся к серверу
  repeat
    client.send(); // Отправляем сообщения в цикле
    write('Хотите ещё отправить сообщение (y/n): ');
    readln(ch);
  until ch = 'n'; 
  client.disconnect(); // Отключаемся от сервера
  sleep(1000);
end.