unit FAG.CadastroUnMedida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FAG.Utils;

type
  TForm_CadastroUnMedida = class(TForm)
    Edit_codigoUnMedida: TEdit;
    Label_codigoUnMedida: TLabel;
    Label_descricaoUnMedida: TLabel;
    Edit_descricaoUnMedida: TEdit;
    FDMemTable1: TFDMemTable;
    BitBtn_salvar: TBitBtn;
    BitBtn_cancelar: TBitBtn;
    EditSigla: TEdit;
    LabelSigla: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn_cancelarClick(Sender: TObject);
    procedure BitBtn_salvarClick(Sender: TObject);
  private
    function getUltimoID: String;
    function validarCampos: Boolean;
    function gravar: Boolean;
    function existeUn(codigo: string): Boolean;
    function existeSIGLA(codigo: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form_CadastroUnMedida: TForm_CadastroUnMedida;

implementation

{$R *.dfm}

Uses
  FAG.Menu, FAG.DataModule.Conexao;

function TForm_CadastroUnMedida.validarCampos: Boolean;
begin
  Result := False;
  if Edit_descricaoUnMedida.Text = '' then
  begin
    ShowMessage('Informe uma descrição.');
    Edit_descricaoUnMedida.SetFocus;
  end
  else if EditSigla.Text = '' then
  begin
    ShowMessage('Informe uma sigla.');
    EditSigla.SetFocus;
  end
  else
  begin
    Result := True;
  end;
end;

function TForm_CadastroUnMedida.existeSIGLA(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT un_medida_sigla FROM un_medida WHERE un_medida_sigla = ' + '"' +
      codigo + '"', excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroUnMedida.existeUn(codigo: string): Boolean;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT un_medida_desc FROM un_medida WHERE un_medida_desc = "' + codigo
      + '"', excist);
    Result := not excist.IsEmpty;
  finally
    FreeAndNil(excist);
  end;
end;

function TForm_CadastroUnMedida.gravar: Boolean;
var
  SQL: String;
begin
  if not validarCampos then
  begin
    Result := False;
    exit;
  end;
  begin
    if not existeUn(Edit_descricaoUnMedida.Text) then
    begin
      if not existeSIGLA(EditSigla.Text) then
      begin
        SQL := ('INSERT INTO un_medida (un_medida_id, un_medida_desc, un_medida_sigla, un_userInclude) '
          + ' VALUES (' + Edit_codigoUnMedida.Text + ',' +
          StrToSQL(Edit_descricaoUnMedida.Text) + ',' + StrToSQL(EditSigla.Text) + ','
          + StrToSQL(Form_Menu.usuarioLogado) + ')');
        DataModuleConexao.ExecSQL(SQL);
        ShowMessage('Salvo com Sucesso.');
        ModalResult := mrOk;
      end
      else
      begin
        Application.MessageBox(PCHAR('A sigla  ' + EditSigla.Text +
          ' já está cadastrada.'), 'Atenção!', MB_ICONWARNING + MB_OK +
          MB_TASKMODAL);
        EditSigla.SetFocus;
      end;
    end
    else
    begin
      Application.MessageBox
        (PCHAR('A unidade de medida  ' + Edit_descricaoUnMedida.Text +
        ' já está cadastrada.'), 'Atenção!', MB_ICONWARNING + MB_OK +
        MB_TASKMODAL);
      EditSigla.SetFocus;
    end;
  end;
end;

procedure TForm_CadastroUnMedida.BitBtn_cancelarClick(Sender: TObject);
begin
  close;
end;

procedure TForm_CadastroUnMedida.BitBtn_salvarClick(Sender: TObject);
begin
  gravar;
end;

procedure TForm_CadastroUnMedida.FormCreate(Sender: TObject);
begin
  Edit_codigoUnMedida.Text := getUltimoID;
end;

function TForm_CadastroUnMedida.getUltimoID: String;
var
  excist: TFDMemTable;
begin
  excist := TFDMemTable.Create(Self);
  try
    DataModuleConexao.ExecSQL
      ('SELECT COALESCE(MAX(un_medida_id)+1, 1) AS ID FROM un_medida', excist);
    Result := excist.FieldByName('ID').AsString;
  finally
    FreeAndNil(excist);
  end;
end;

end.
