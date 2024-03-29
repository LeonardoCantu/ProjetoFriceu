unit FAG.ConsultaUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FAG.Frame.Generico, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask;

type
  TForm_ConsultaUsuario = class(TForm)
    Panel_relatorioMovimento: TPanel;
    Label_ConsultarUsua: TLabel;
    SpeedButton_exibirTodos: TSpeedButton;
    SpeedButton_limparConsulta: TSpeedButton;
    SpeedButton_Voltar: TSpeedButton;
    GroupBox1: TGroupBox;
    Label_produto: TLabel;
    Label_filtro: TLabel;
    GroupBox_Pesquisa: TGroupBox;
    Frame_Status: TFrame_Generico;
    resultadoUsuario: TDBGrid;
    ComboBox_Filtro: TComboBox;
    Bit_Filtrar: TBitBtn;
    FDMemTable_Usuario: TFDMemTable;
    DataSource_Consulta: TDataSource;
    Edit_pesquisa: TEdit;
    procedure SpeedButton_VoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure Bit_FiltrarClick(Sender: TObject);
    procedure resultadoUsuarioDblClick(Sender: TObject);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
  private
    function carregaFrame: Boolean;
    function carregaFiltros: Boolean;
    function carregaDBgrid: Boolean;
    function carregaTodos: Boolean;
    function filtrarDesc: Boolean;
    function filtrarCPF: Boolean;
    function filtrarCNPJ: Boolean;

  public
    { Public declarations }
  end;

var
  Form_ConsultaUsuario: TForm_ConsultaUsuario;


implementation

{$R *.dfm}

uses FAG.DataModule.Conexao;

{ TForm1 }

const
  SQL_SELECT: String = 'SELECT pes_id_pessoa as C�digo, pes_nome as Nome, ' +
   ' IF(pes_cnpj IS NULL, CONCAT("CPF: ",pes_cpf), CONCAT("CNPJ: ",pes_cnpj)) AS Inscri��o, '+
    ' pes_celular as Celular, IF(pes_ativo = 1, CONCAT("ATIVO"), CONCAT("INATIVO"))as Status FROM pessoa WHERE 1>0 ';


procedure TForm_ConsultaUsuario.Bit_FiltrarClick(Sender: TObject);
begin
  case ComboBox_Filtro.ItemIndex of
    0:
      begin
        ShowMessage('Selecione um filtro.');
      end;
    1:
      begin
        filtrarDesc;
      end;
    2:
      begin
        filtrarCPF;
      end;
    3:
      begin
        filtrarCNPJ;
      end;
  end;

end;

function TForm_ConsultaUsuario.carregaDBgrid: Boolean;
begin
  resultadoUsuario.Columns[0].FieldName := 'C�digo';
  resultadoUsuario.Columns[1].FieldName := 'Nome';
  resultadoUsuario.Columns[2].FieldName := 'Inscri��o';
  //resultadoUsuario.Columns[3].FieldName := 'CNPJ';
  resultadoUsuario.Columns[3].FieldName := 'Celular';
  resultadoUsuario.Columns[4].FieldName := 'Status';
end;

function TForm_ConsultaUsuario.carregaFiltros: Boolean;
begin
  ComboBox_Filtro.clear;
  ComboBox_Filtro.Style := csDropDownList;
  ComboBox_Filtro.Items.Add('Selecione');
  ComboBox_Filtro.Items.Add('1 - Nome');
  ComboBox_Filtro.Items.Add('2 - CPF');
  ComboBox_Filtro.Items.Add('3 - CNPJ');
  ComboBox_Filtro.ItemIndex := 0;
end;

function TForm_ConsultaUsuario.carregaFrame: Boolean;
begin
  Frame_Status.tabela := 'situacao';
  Frame_Status.campoChave := 'sit_id';
  Frame_Status.campoDescricao := 'sit_descricao';
  Frame_Status.camposExtras := '';
  Frame_Status.condicao := '';
  Frame_Status.titulo := 'Status';
  Frame_Status.primeiraOpcao := 'Ambos';
  Frame_Status.carregaFrame := True;
end;
function TForm_ConsultaUsuario.carregaTodos: Boolean;
var
  sql: String;
begin
  sql := SQL_SELECT+' order by pes_id_pessoa ';
  DataModuleConexao.ExecSQL(sql, FDMemTable_Usuario);
end;


function TForm_ConsultaUsuario.filtrarCNPJ: Boolean;
var
  sql: String;
begin
  if Frame_Status.indexCombo = '0' then
  begin
    sql := SQL_SELECT;
    if Edit_pesquisa.Text <> EmptyStr then
      sql := sql + ' AND pes_cnpj LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '1' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 1 AND pes_cnpj LIKE "%' +  Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '2' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 2 AND pes_cnpj LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;

  DataModuleConexao.ExecSQL(sql, FDMemTable_Usuario);
end;

function TForm_ConsultaUsuario.filtrarCPF: Boolean;
var
  sql: String;
begin
  if Frame_Status.indexCombo = '0' then
  begin
    sql := SQL_SELECT;
    if Edit_pesquisa.Text <> EmptyStr then
      sql := sql + ' AND pes_cpf LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '1' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 1 AND pes_cpf LIKE "%' +  Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '2' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 2 AND pes_cpf LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;

  DataModuleConexao.ExecSQL(sql, FDMemTable_Usuario);
end;

function TForm_ConsultaUsuario.filtrarDesc: Boolean;
var
  sql: String;
begin
  if Frame_Status.indexCombo = '0' then
  begin
    sql := SQL_SELECT;
    if Edit_pesquisa.Text <> EmptyStr then
      sql := sql + ' AND pes_nome LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '1' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 1 AND pes_nome LIKE "%' +  Edit_pesquisa.Text + '%" ';
  end;
  if Frame_Status.indexCombo = '2' then
  begin
    sql := SQL_SELECT+' AND pes_ativo = 2 AND pes_nome LIKE "%' + Edit_pesquisa.Text + '%" ';
  end;

  DataModuleConexao.ExecSQL(sql, FDMemTable_Usuario);
end;


procedure TForm_ConsultaUsuario.FormCreate(Sender: TObject);
begin
  carregaFrame;
  carregaFiltros;
  carregaDBgrid;
end;

procedure TForm_ConsultaUsuario.resultadoUsuarioDblClick(Sender: TObject);
begin
  if not FDMemTable_Usuario.IsEmpty then
    ModalResult := mrOk;
end;

procedure TForm_ConsultaUsuario.SpeedButton_exibirTodosClick(Sender: TObject);
begin
  carregaTodos;
end;

procedure TForm_ConsultaUsuario.SpeedButton_limparConsultaClick
  (Sender: TObject);
begin
  if not FDMemTable_Usuario.IsEmpty then
  begin
    FDMemTable_Usuario.Open;
    FDMemTable_Usuario.EmptyDataSet;
    FDMemTable_Usuario.Close;
    FDMemTable_Usuario.Open;
  end;
  Frame_Status.ComboBox_Informacao.ItemIndex := 0;
  ComboBox_Filtro.ItemIndex := 1;
  Edit_pesquisa.clear;
end;

procedure TForm_ConsultaUsuario.SpeedButton_VoltarClick(Sender: TObject);
begin
  Form_ConsultaUsuario.Close;
end;

end.
