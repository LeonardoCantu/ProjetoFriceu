unit FAG.CadastroCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm_CadastroCategoria = class(TForm)
    BitBtn_salvar: TBitBtn;
    BitBtn_cancelar: TBitBtn;
    Edit_codigo: TEdit;
    Label_codigo: TLabel;
    Edit_descricao: TEdit;
    Label_descricao: TLabel;
    FDMemTable1: TFDMemTable;
    procedure BitBtn_cancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn_salvarClick(Sender: TObject);
  private
    function getUltimoID: String;
    function validarCampos: Boolean;
    function gravar: Boolean;
    function existeCategoria(codigo: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form_CadastroCategoria: TForm_CadastroCategoria;

implementation

{$R *.dfm}

Uses
  FAG.Menu, FAG.DataModule.Conexao, FAG.CadastroProduto, FAG.Frame.Generico,
  FAG.Utils;

procedure TForm_CadastroCategoria.BitBtn_cancelarClick(Sender: TObject);
begin
  close;
end;

procedure TForm_CadastroCategoria.BitBtn_salvarClick(Sender: TObject);
begin
  gravar;
end;

procedure TForm_CadastroCategoria.FormCreate(Sender: TObject);
begin
  Edit_codigo.Text := getUltimoID;
end;

function TForm_CadastroCategoria.getUltimoID: String;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT COALESCE(MAX(cat_id_categoria)+1, 1) AS ID FROM categoria',
      excist);
    Result := excist.FieldByName('ID').AsString;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroCategoria.existeCategoria(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT cat_id_categoria , cat_desc FROM categoria WHERE cat_desc =   ' +
      '"' + codigo + '"', excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroCategoria.gravar: Boolean;
var
  SQL: String;
begin
  if not validarCampos then
  begin
    Result := False;
    Exit;
  end;
  if existeCategoria(Edit_descricao.Text) then
  begin
     Application.MessageBox
        (PCHAR('A Categoria ' + Edit_descricao.Text +
        ' j� est� cadastrada.'), 'Aten��o!', MB_ICONWARNING + MB_OK +
        MB_TASKMODAL);
      Edit_descricao.SetFocus;
  end
  else
  begin
    SQL := 'INSERT INTO categoria (cat_id_categoria, cat_desc, cat_data_cadastro, cat_userInclude) '
      + ' VALUES (' + Edit_codigo.Text + ',"' + Edit_descricao.Text +
      '",NOW(),'+ StrToSQL(Form_Menu.usuarioLogado)  +')';
    DataModuleConexao.ExecSQL(SQL);
    ShowMessage('Salvo com Sucesso.');
    ModalResult := mrOk;
  end;
end;

function TForm_CadastroCategoria.validarCampos: Boolean;
begin
  Result := False;
  if Edit_descricao.Text = '' then
  begin
    ShowMessage('Informe uma descri��o para Categoria!');
    Edit_descricao.SetFocus;
  end
  else
  begin
    Result := True;
  end;
end;

end.
