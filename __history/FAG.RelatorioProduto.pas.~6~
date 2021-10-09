unit FAG.RelatorioProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FAG.Frame.Produto, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, frxExportCSV, frxClass, frxExportBaseDialog, frxExportPDF,
  frxDBSet, frxExportRTF, frxExportText;

type
  TForm_RelatorioProduto = class(TForm)
    Panel_Principal: TPanel;
    GroupBox_consulta: TGroupBox;
    Label_categoria: TLabel;
    Label_tipoMoviemento: TLabel;
    SpeedButton_filtrar: TSpeedButton;
    ComboBox_categoria: TComboBox;
    ComboBox_Status: TComboBox;
    Label_tituloForm: TLabel;
    Frame_Produto1: TFrame_Produto;
    GroupBox_grid: TGroupBox;
    Panel_grid: TPanel;
    SpeedButton_limparConsulta: TSpeedButton;
    SpeedButton_exportar: TSpeedButton;
    SpeedButton_sair: TSpeedButton;
    DBGrid_Pesquisa: TDBGrid;
    DataSource_Consulta: TDataSource;
    FDMemTable_Consulta: TFDMemTable;
    frxReportExport: TfrxReport;
    frxDBDatasetExport: TfrxDBDataset;
    exportPDF: TfrxPDFExport;
    exportEXCEL: TfrxCSVExport;
    exportTXT: TfrxSimpleTextExport;
    exportWORD: TfrxRTFExport;
    FDMemTable_Consultaprod_id_produto: TIntegerField;
    FDMemTable_Consultaprod_desc: TWideStringField;
    FDMemTable_Consultaun_medida_desc: TWideStringField;
    FDMemTable_Consultacat_desc: TWideStringField;
    FDMemTable_Consultaprod_data_cadastro: TDateTimeField;
    FDMemTable_Consultaprod_quantidade: TIntegerField;
    SpeedButton_exibirTodos: TSpeedButton;
    procedure SpeedButton_sairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton_filtrarClick(Sender: TObject);
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure SpeedButton_exportarClick(Sender: TObject);
    procedure FDMemTable_Consultaprod_quantidadeGetText(Sender: TField; var Text: string; DisplayText: Boolean);

  private
    procedure alimentaCategoria;
    procedure buscaMovimento;
  public
    { Public declarations }
  end;

var
  Form_RelatorioProduto: TForm_RelatorioProduto;

implementation

{$R *.dfm}
Uses
  FAG.Menu, FAG.DataModule.Conexao;

  procedure TForm_RelatorioProduto.alimentaCategoria;
var
  categoria: TFDMemTable;

begin
  categoria := TFDMemTable.Create(Self);

  try
    DataModuleConexao.ExecSQL('SELECT cat_desc FROM categoria', categoria);
    ComboBox_categoria.Items.Add('Todos');
    categoria.First;
    while not categoria.Eof do
    begin
      ComboBox_categoria.Items.Add(categoria.FieldByName('cat_desc').AsString);
      categoria.Next;
    end;
    ComboBox_categoria.ItemIndex := 0;
  finally
    FreeAndNil(categoria);
  end;
end;


procedure TForm_RelatorioProduto.buscaMovimento;
var
  sql: String;
begin
  sql := 'SELECT prod_id_produto, prod_desc, un_medida_desc, cat_desc, prod_data_cadastro, '
  +' prod_quantidade FROM produto AS p INNER JOIN categoria AS c ON p.cat_id_categoria = c.cat_id_categoria '
  +'INNER JOIN un_medida AS un ON p.un_medida_id = un.un_medida_id WHERE  1 > 0 ';

  if Frame_Produto1.Edit_codigoProduto.Text <> EmptyStr then
  begin
    sql := sql + ' AND (p.prod_id_produto = ' + Frame_Produto1.FDMemTable_Produto.FieldByName('prod_id_produto').AsString + ')'
  end;

  if ComboBox_categoria.ItemIndex <> 0  then
  begin
    sql := sql + ' AND (c.cat_id_categoria = ' +
      ComboBox_categoria.ItemIndex.ToString + ')'
  end;

  if ComboBox_Status.ItemIndex <> 0  then
  begin
    sql := sql + ' AND (p.prod_ativo = "' + ComboBox_Status.ItemIndex.ToString + '")'
  end;

  DataModuleConexao.ExecSQL(sql, FDMemTable_Consulta);


  if FDMemTable_Consulta.IsEmpty then
  begin
    Application.MessageBox ('Nenhum registro encontrado','Erro',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

procedure TForm_RelatorioProduto.FDMemTable_Consultaprod_quantidadeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender as TField).AsString = '' then
    text := '0'
  else
    text := (Sender as TField).AsString;
end;

procedure TForm_RelatorioProduto.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  Action := caFree;

  Form_RelatorioProduto := nil;
end;

procedure TForm_RelatorioProduto.FormCreate(Sender: TObject);
begin
  alimentaCategoria;
  ComboBox_Status.Items.Add('TODOS');
  ComboBox_Status.Items.Add('ATIVO');
  ComboBox_Status.Items.Add('INATIVO');
  ComboBox_Status.ItemIndex := 0;
  DBGrid_Pesquisa.Columns[0].FieldName := 'prod_id_produto';
  DBGrid_Pesquisa.Columns[1].FieldName := 'prod_desc';
  DBGrid_Pesquisa.Columns[2].FieldName := 'un_medida_desc';
  DBGrid_Pesquisa.Columns[3].FieldName := 'cat_desc';
  DBGrid_Pesquisa.Columns[4].FieldName := 'prod_data_cadastro';
  DBGrid_Pesquisa.Columns[5].FieldName := 'prod_quantidade';
end;





procedure TForm_RelatorioProduto.SpeedButton_exibirTodosClick(Sender: TObject);
var
  sql: String;
begin
  sql := 'SELECT prod_id_produto, prod_desc, un_medida_desc, cat_desc, prod_data_cadastro, '
  +' prod_quantidade FROM produto AS p INNER JOIN categoria AS c ON p.cat_id_categoria = c.cat_id_categoria '
  +'INNER JOIN un_medida AS un ON p.un_medida_id = un.un_medida_id WHERE  1 > 0 order by prod_id_produto ';

  DataModuleConexao.ExecSQL(sql, FDMemTable_Consulta);
  

  end;

procedure TForm_RelatorioProduto.SpeedButton_exportarClick(Sender: TObject);
begin
 // frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'relatorio.fr3');
  if FDMemTable_Consulta.IsEmpty then
  begin
   Application.MessageBox ('Realize uma pesquisa para exportar','Erro',MB_OK+MB_ICONEXCLAMATION);
   exit
  end;
    //frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'relatorioUsuario.fr3') ;
    frxReportExport.ShowReport();
end;

procedure TForm_RelatorioProduto.SpeedButton_filtrarClick(Sender: TObject);
begin
  if (Frame_Produto1.Edit_codigoProduto.Text = EmptyStr) AND (ComboBox_categoria.ItemIndex = 0) AND(ComboBox_Status.ItemIndex = 0) then
  begin
     Application.MessageBox ('Preencha a pesquisa','Erro',MB_OK+MB_ICONEXCLAMATION);
     exit
  end;
  buscaMovimento;
end;

procedure TForm_RelatorioProduto.SpeedButton_limparConsultaClick(Sender: TObject);
begin
  if not FDMemTable_Consulta.IsEmpty  then
  begin
  FDMemTable_Consulta.Open;
  FDMemTable_Consulta.EmptyDataSet;
  FDMemTable_Consulta.Close;
  FDMemTable_Consulta.Open;
  end;
  Frame_Produto1.Edit_descricao.Clear;
  Frame_Produto1.Edit_codigoProduto.Clear;
  ComboBox_categoria.ItemIndex := 0;
  ComboBox_Status.ItemIndex := 0;
end;

procedure TForm_RelatorioProduto.SpeedButton_sairClick(Sender: TObject);
begin
Form_RelatorioProduto.Close;
end;

end.
