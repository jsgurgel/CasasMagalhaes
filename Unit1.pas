unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function IsUrl(S: string): Boolean;
//
// Testa se a String é uma url ou não
//
const
BADCHARS = ';*<>{}[]|\()^!';
var
p, x, c, count, i: Integer;
begin
Result := False;
if (Length(S) > 5) and (S[Length(S)] <> '.') and (Pos(S, '..') = 0) then
   begin
   for i := Length(BADCHARS) downto 1 do
       begin
       if Pos(BADCHARS[i], S) > 0 then
          begin
          exit;
          end;
       end;
   for i := 1 to Length(S) do
       begin
       if (Ord(S[i]) < 33) or (Ord(S[i]) > 126) then
          begin
          exit;
          end;
       end;
   if ((Pos('www.',LowerCase(S)) = 1) and (Pos('.', Copy(S, 5, Length(s))) > 0) and (Length(S) > 7)) or ((Pos('news:', LowerCase(S)) = 1) and (Length(S) > 7) and (Pos('.', Copy(S, 5, Length(S))) > 0)) then
       begin
       end
   else if ((Pos('mailto:', LowerCase(S)) = 1) and (Length(S) > 12) and (Pos('@', S) > 8) and (Pos('.', S) > 10) and (Pos('.', S) > (Pos('@', S) +1))) or ((Length(S) > 6) and (Pos('@', S) > 1) and (Pos('.', S) > 4) and (Pos('.', S) > (Pos('@', S) +1))) then
            begin
            Result := True;
            Exit;
            end
   else if ((Pos('http://', LowerCase(S)) = 1) and (Length(S) > 10) and (Pos('.', S) > 8)) or ((Pos('ftp://', LowerCase(S)) = 1) and (Length(S) > 9) and (Pos('.', S) > 7)) then
           begin
           Result := True;
           Exit;
           end
        else
           begin
           Result := True;
           end;
   for Count := 1 to 4 do
       begin
       p := Pos('.',S) - 1;
       if p < 0 then
          begin
          p := Length(S);
          end;
        Val(Copy(S, 1, p), x, c);
        if ((c <> 0) or (x < 0) or (x > 255) or (p>3)) then
           begin
           Result := False;
           Break;
           end;
        Delete(S, 1, p + 1);
        end;
   if (S <> '') then
       begin
       Result := False;
       end;
   end;
 end;

Function domainName(Value:String):String;
Var
  I:Integer;
  fValue:String;
Begin
  fValue := 'Favor informar a URL';
  if Trim(Value) <>'' then
  Begin
    I:=Pos('.', Value);
    fValue := Copy(Value, I+1, Length(Value));
    I:=Pos('.', fValue);
    fValue := Copy(fValue, 1, I-1);
    if fValue = '' then
    Begin
      I:=Pos('.', Value);
      fValue := Copy(Value, 1, I-1);
      I:=Pos(':', fValue);
      fValue := Copy(fValue, I+3, Length(fValue));
    End;
  End;
  Result:=fValue;
End;

Function Cript(Value:String):String;
Function _Cript(Value:String):String;
Begin
  Result := IntToStr(Ord(Char(Value[1]))) + Value[Length(Value)]  + Copy(Value, 3, Length(Value) - 3) + Value[2];
End;

VAr
  I:INteger;
  Palavra, Fase:String;
Begin
  Palavra := '';
  Fase := '';
  for I := 1 to Length(Value) do
    if (Value[I] <> ' ') and (I <=  Length(Value)) then
    Begin
      Palavra := Palavra + Value[I];
      if (Value[I + 1] = ' ') or (Value[I + 1] = '') then
      Begin
        Fase := Fase + ' ' + _Cript(Palavra);
        if Value[I+1] <> '' then
          Palavra := '';
      end;
    end;
   Result := Fase;
 End;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(domainName(Edit1.text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowMessage(Cript(Edit1.Text));
end;

end.
// https://jsonplaceholder.typicode.com/
