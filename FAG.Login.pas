unit FAG.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL,
  Vcl.Imaging.jpeg, Vcl.Buttons, Vcl.Imaging.pngimage, System.ImageList,
  Vcl.ImgList;

type
  TForm_Login = class(TForm)
    Panel_Login: TPanel;
    FAG_Logo: TImage;
    FDMemTable1: TFDMemTable;
    Shape1: TShape;
    Edit_senha: TEdit;
    ovI_ImagemSenha: TImage;
    ovP_Entrar: TPanel;
    ovB_Entrar: TButton;
    ovP_Cancelar: TPanel;
    ovB_Cancelar: TButton;
    ovS_Cancelar: TShape;
    ovI_ImagemLogin: TImage;
    Shape2: TShape;
    Edit_usuario: TEdit;
    ImagemAparecer: TImage;
    procedure entrarClick(Sender: TObject);
    procedure ovP_CancelarClick(Sender: TObject);
    procedure ovP_EntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImagemAparecerClick(Sender: TObject);
    procedure Edit_usuarioKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_senhaKeyPress(Sender: TObject; var Key: Char);
    procedure ImagemOcultarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagemOcultarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagemAparecerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagemAparecerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    function EncryptSTR(const Key, texto: String): String;
    function user_ativo(codigo: string): Boolean;
    function exist(Login: String; var senha: String): Boolean;
    // function existe_usuario(codigo: String): Boolean;
    function confirmar: Boolean;
    function validarCampos: Boolean;
  public

  end;

var
  Form_Login: TForm_Login;

implementation

{$R *.dfm}

uses FAG.DataModule.Conexao,
  FAG.Menu,
  FAG.Utils;

function TForm_Login.confirmar: Boolean;
var
  SQL: String;
begin
  if not validarCampos then
  begin
    Result := False;
    Exit;
  end;

  if not Assigned(Form_Menu) then
    Form_Menu.Hide;
  Form_Menu.usuarioLogado := Edit_usuario.Text;
  ModalResult := mrOk;
end;

function TForm_Login.EncryptSTR(const Key, texto: String): String;
var
  I: Integer;
  C: Byte;
begin
  Result := '';
  for I := 1 to Length(texto) do
  begin
    if Length(Key) > 0 then
      C := Byte(Key[1 + ((I - 1) mod Length(Key))]) xor Byte(texto[I])
    else
      C := Byte(texto[I]);
    Result := Result + AnsiLowerCase(IntToHex(C, 2));
  end;
end;

procedure TForm_Login.Edit_senhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    confirmar;
end;

procedure TForm_Login.Edit_usuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    confirmar;
end;

procedure TForm_Login.entrarClick(Sender: TObject);
begin
  confirmar;
end;

// function TForm_Login.existe_usuario(codigo: String): Boolean;
// var
// excist: TFDMemTable;
// begin
// excist := TFDMemTable.Create(Self);
// try
// DataModuleConexao.ExecSQL
// ('SELECT login_usuario, login_senha FROM login WHERE  login_usuario = ' +
// StrToSQL(codigo) + ' AND login_senha ="' + EncryptSTR(Edit_senha.Text,
// Edit_usuario.Text) + '"', excist);
// Result := not excist.IsEmpty;
// finally
// FreeAndNil(excist);
// end;
// end;

procedure TForm_Login.FormShow(Sender: TObject);
begin
  ImagemAparecer.Visible := True;
end;

procedure TForm_Login.ImagemAparecerClick(Sender: TObject);
begin
  if ImagemAparecer.Visible = True then
  begin
    Edit_senha.PasswordChar := #0;
    ImagemAparecer.Visible := False;
  end;
end;

procedure TForm_Login.ImagemAparecerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Edit_senha.PasswordChar := #0;
end;

procedure TForm_Login.ImagemAparecerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Edit_senha.PasswordChar := '*';
end;

procedure TForm_Login.ImagemOcultarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Edit_senha.PasswordChar := #0;
end;

procedure TForm_Login.ImagemOcultarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Edit_senha.PasswordChar := '*';
end;

procedure TForm_Login.ovP_CancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm_Login.ovP_EntrarClick(Sender: TObject);
begin
  confirmar;
end;

function TForm_Login.exist(Login: String; var senha: String): Boolean;
var
  excist: TFDMemTable;
begin
  Result := False;
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL('SELECT login_usuario, ' +
      ' AES_DECRYPT(login_senha,"' + Key + '") AS login_senha FROM Login ' +
      ' WHERE login_usuario = ' + StrToSQL(Login), excist);

    // if ((excist.FieldByName('login_usuario').AsString = Edit_usuario.Text) AND
    // (excist.FieldByName('login_senha').AsString = Edit_senha.Text)) then
    // begin

    if not excist.IsEmpty then
    begin
      Result := True;
      senha := excist.FieldByName('login_senha').AsString;
    end
    else
      senha := EmptyStr;

  finally
    FreeAndNil(excist);
  end;
end;

function TForm_Login.user_ativo(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL('SELECT login_usuario, login_senha, pes_ativo FROM login AS A ' +
      'INNER JOIN pessoa AS B ON A.login_pes_id_pessoa = B.pes_id_pessoa ' +
      'WHERE pes_ativo = 1 AND login_usuario = ' + StrToSQL(codigo), excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_Login.validarCampos: Boolean;
var
  consultaSenha: String;
begin
  Result := False;
  if Edit_usuario.Text = '' then
  begin
    Application.MessageBox('O campo login n�o foi preenchido.',
      'Aten��o, campo n�o preenchido', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Edit_usuario.SetFocus;
  end
  else if Edit_senha.Text = '' then
  begin
    Application.MessageBox('O campo senha n�o foi preenchido.',
      'Aten��o, campo n�o preenchido', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
    Edit_senha.SetFocus;
  end
  else if not exist(Edit_usuario.Text, consultaSenha) then
  begin
    Application.MessageBox('Usu�rio ou senha inserido est� inv�lido/incorreto, tente novamente.',
      'N�O FOI POSS�VEL LOGAR', MB_OK + MB_ICONHAND + MB_TASKMODAL);
  end
  else if consultaSenha <> Edit_senha.Text then
  begin
    Application.MessageBox('Senha inv�lida/incorreta, tente novamente.',
      'N�O FOI POSS�VEL LOGAR', MB_OK + MB_ICONHAND + MB_TASKMODAL);
  end
  else
  if not user_ativo(Edit_usuario.Text) then
  begin
    Application.MessageBox('Usu�rio inativo, solicite ao administrador a ativa��o.',
      'N�O FOI POSS�VEL LOGAR', MB_OK + MB_ICONHAND + MB_TASKMODAL);
  end
  else
  begin
    Result := True;
  end;
end;

end.
