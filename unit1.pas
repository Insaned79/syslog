unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls,INIFiles,FileUtil;

type

  { Tsettings }

  Tsettings = class(TForm)
    host: TEdit;
    database: TEdit;
    login: TEdit;
    password: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    okbtn: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    connection: TMySQL57Connection;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
  private

  public

  end;



var
  settings: Tsettings;

implementation

{$R *.lfm}

{ Tsettings }

procedure Tsettings.BitBtn3Click(Sender: TObject);
begin
  connection.Connected:=False;
  connection.HostName:=host.Text;
  connection.DatabaseName:=database.Text;
  connection.UserName:=login.text;
  connection.Password:=password.text;
  try
     connection.Connected:=True;
  except
     connection.Connected:=False;
  end;

 if connection.Connected then okbtn.enabled := True else okbtn.enabled := False;


//  okbtn.Enabled:= not(okbtn.Enabled);
end;

procedure Tsettings.FormShow(Sender: TObject);
var
  inifile: string;
  IniF: TINIFile;
begin
  okbtn.Enabled:=False;

  inifile:=ExtractFileDir(paramstr(0));
  inifile:=inifile+'/settings.ini';
  if FileExists(inifile) then
  begin
      Inif := TINIFile.Create(inifile);
      host.Text := Inif.ReadString('Main','Host','');
      database.Text := Inif.ReadString('Main','DataBase','');
      login.Text := Inif.ReadString('Main','UserName','');
      password.Text := Inif.ReadString('Main','Password','');
      Inif.Destroy;
  end
  else
  begin
    host.Text:='';
    database.Text:='';
    login.Text:='';
    password.Text:='';
  end;




end;

procedure Tsettings.okbtnClick(Sender: TObject);
var
  inifile: string;
  IniF: TINIFile;
  fp: textfile;
begin
  inifile:=ExtractFileDir(paramstr(0));
  inifile:=inifile+'/settings.ini';
  if FileExists(inifile) then
  begin
      Inif := TINIFile.Create(inifile);
  end
  else
    begin
      AssignFile(fp, inifile);
      rewrite(fp);
      closefile(fp);
      Inif := TINIFile.Create(inifile);
  end;

  Inif.WriteString('Main','Host',host.Text);
  Inif.WriteString('Main','DataBase',database.Text);
  Inif.WriteString('Main','UserName',login.Text);
  Inif.WriteString('Main','Password',password.Text);
  Inif.Destroy;

end;

end.

