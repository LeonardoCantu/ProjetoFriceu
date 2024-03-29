unit FAG.ConsultarProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, FAG.Frame.Generico, FAG.Utils, FAG.CadastroProduto;

type
  TForm_ConsultarProduto = class(TForm)
    Panel_relatorioMovimento: TPanel;
    Label_ConsultarProd: TLabel;
    SpeedButton_exibirTodos: TSpeedButton;
    GroupBox1: TGroupBox;
    Label_produto: TLabel;
    Edit_produto: TEdit;
    GroupBox2: TGroupBox;
    Panel_resultadoPesquisa: TPanel;
    SaveDialog1: TSaveDialog;
    FDMemTable_consultaProduto: TFDMemTable;
    DataSource_consultaProduto: TDataSource;
    ComboBox_filtro: TComboBox;
    SpeedButton_limparConsulta: TSpeedButton;
    SpeedButton_Voltar: TSpeedButton;
    Label_filtro: TLabel;
    DBGrid_resultadoPesquisa: TDBGrid;
    Frame_categoria: TFrame_Generico;
    BitBtn1: TBitBtn;
    procedure SpeedButton_exibirTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid_resultadoPesquisaDblClick(Sender: TObject);
    procedure SpeedButton_limparConsultaClick(Sender: TObject);
    procedure SpeedButton_VoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Frame_categoriaComboBox_InformacaoExit(Sender: TObject);
    procedure ComboBox_filtroChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    function carregaFiltros: Boolean;
    function carregaCategoria: Boolean;
    function carregaDB: Boolean;
    function filtrarCod: Boolean;
    function filtrarDesc: Boolean;
    function filtrarCat: Boolean;
    function limpaGrid: Boolean;
    function filtrarTodos: Boolean;
  public
    { Public declarations }
  end;

var
  Form_ConsultarProduto: TForm_ConsultarProduto;

implementation

{$R *.dfm}

Uses

  FAG.DataModule.Conexao;



procedure TForm_ConsultarProduto.BitBtn1Click(Sender: TObject);
begin
   case ComboBox_filtro.ItemIndex of
    0:
      begin
      Application.MessageBox(PCHAR('Selecione um filtro.'),
      'Aten��o!', MB_ICONWARNING + MB_OK + MB_TASKMODAL);
      end;
    1:
      begin
        filtrarCod;
      end;
    2:
      begin
        filtrarDesc;
      end;
    3:
      begin
        Self.Perform(WM_NEXTDLGCTL, 0, 0);
        filtrarCat;
      end;
  end;
end;

function TForm_ConsultarProduto.carregaCategoria: Boolean;
begin
  Frame_categoria.tabela := 'categoria';
  Frame_categoria.campoChave := 'cat_id_categoria';
  Frame_categoria.campoDescricao := 'cat_desc';
  // Frame_Categoria.camposExtras := ',cat_data_cadastro, cat_data_alterado';
  Frame_categoria.condicao := '';
  Frame_categoria.titulo := 'Categorias';
  Frame_categoria.primeiraOpcao := 'Escolha';
  Frame_categoria.carregaFrame := True;
end;

function TForm_ConsultarProduto.carregaDB: Boolean;
begin
  DBGrid_resultadoPesquisa.Columns[0].FieldName := 'C�digo';
  DBGrid_resultadoPesquisa.Columns[1].FieldName := 'Descri��o';
  DBGrid_resultadoPesquisa.Columns[2].FieldName := 'Categoria';
end;

function TForm_ConsultarProduto.carregaFiltros: Boolean;
begin
  ComboBox_filtro.clear;
  ComboBox_filtro.Style := csDropDownList;
  ComboBox_filtro.Items.Add('Selecione');
  ComboBox_filtro.Items.Add('1 - C�digo');
  ComboBox_filtro.Items.Add('2 - Descri��o');
  ComboBox_filtro.Items.Add('3 - Categoria');
  ComboBox_filtro.ItemIndex := 0;
end;

procedure TForm_ConsultarProduto.ComboBox_filtroChange(Sender: TObject);
begin
  case ComboBox_filtro.ItemIndex of
    1:
      begin
           Edit_produto.Enabled := True;
           Frame_categoria.ComboBox_Informacao.Enabled := False;
           Edit_produto.SetFocus;
           Edit_produto.Hint := 'Informe dados para consulta';
           Edit_produto.ShowHint := True;
      end;
    2:
      begin
           Edit_produto.Enabled := True;
           Frame_categoria.ComboBox_Informacao.Enabled := False;
           Edit_produto.SetFocus;
           Edit_produto.Hint := 'Informe dados para consulta';
           Edit_produto.ShowHint := True;
      end;
    3:
      begin
        Edit_produto.clear;
        Edit_produto.Enabled := False;
        Frame_categoria.ComboBox_Informacao.Enabled := True;
        Frame_categoria.ComboBox_Informacao.SetFocus;
        Frame_categoria.ComboBox_Informacao.Hint := 'Selecione a categoria';
        Frame_categoria.ComboBox_Informacao.ShowHint := True;
      end;
  end;
end;

procedure TForm_ConsultarProduto.DBGrid_resultadoPesquisaDblClick
  (Sender: TObject);
begin
  if not FDMemTable_consultaProduto.IsEmpty then
    ModalResult := mrOk;
end;

function TForm_ConsultarProduto.filtrarCat: Boolean;
var
  sql: String;
begin
  sql := 'SELECT ' + 'prod_id_produto AS C�digo,' + 'prod_desc AS Descri��o, ' +
    'B.cat_desc AS Categoria ' +

    ' FROM produto AS A ' +
    ' INNER JOIN categoria as B ON A.cat_id_categoria = B.cat_id_categoria ' +
    ' INNER JOIN un_medida as C ON A.un_medida_id = C.un_medida_id WHERE A.cat_id_categoria = "'
    + Frame_categoria.indexCombo + '" ORDER BY prod_id_produto';
  DataModuleConexao.ExecSQL(sql, FDMemTable_consultaProduto);
end;

function TForm_ConsultarProduto.filtrarCod: Boolean;
var
  sql: String;
begin
  sql := 'SELECT ' + 'prod_id_produto AS C�digo,' + 'prod_desc AS Descri��o, ' +
    'B.cat_desc AS Categoria ' +

    ' FROM produto AS A ' +
    ' INNER JOIN categoria as B ON A.cat_id_categoria = B.cat_id_categoria ' +
    ' INNER JOIN un_medida as C ON A.un_medida_id = C.un_medida_id ' +
    ' WHERE prod_id_produto = "' + Edit_produto.Text +
    '" ORDER BY prod_id_produto';
  DataModuleConexao.ExecSQL(sql, FDMemTable_consultaProduto);
end;

function TForm_ConsultarProduto.filtrarDesc: Boolean;
var
  sql: String;
begin
  sql := 'SELECT ' + 'prod_id_produto AS C�digo,' + 'prod_desc AS Descri��o, ' +
    'B.cat_desc AS Categoria ' +

    ' FROM produto AS A ' +
    ' INNER JOIN categoria as B ON A.cat_id_categoria = B.cat_id_categoria ' +
    ' INNER JOIN un_medida as C ON A.un_medida_id = C.un_medida_id WHERE prod_desc LIKE "%'
    + Edit_produto.Text + '%" ORDER BY prod_id_produto';
  DataModuleConexao.ExecSQL(sql, FDMemTable_consultaProduto);
end;

function TForm_ConsultarProduto.filtrarTodos: Boolean;
var
  sql: String;
begin
  sql := 'SELECT ' + 'prod_id_produto AS C�digo,' + 'prod_desc AS Descri��o, ' +
    'B.cat_desc AS Categoria ' + ' FROM produto AS A ' +
    ' INNER JOIN categoria as B ON A.cat_id_categoria = B.cat_id_categoria ORDER BY prod_id_produto';
  DataModuleConexao.ExecSQL(sql, FDMemTable_consultaProduto);
end;

procedure TForm_ConsultarProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  Release;
  Form_ConsultarProduto := nil;
end;

procedure TForm_ConsultarProduto.FormCreate(Sender: TObject);
begin
  carregaCategoria;
  carregaFiltros;
  carregaDB;
end;

procedure TForm_ConsultarProduto.Frame_categoriaComboBox_InformacaoExit
  (Sender: TObject);
begin
  Frame_categoria.ComboBox_InformacaoExit(Sender);
end;

function TForm_ConsultarProduto.limpaGrid: Boolean;
begin
  FDMemTable_consultaProduto.Close;
  Frame_categoria.ComboBox_Informacao.ItemIndex := 0;
  ComboBox_filtro.ItemIndex := 0;
end;

procedure TForm_ConsultarProduto.SpeedButton_exibirTodosClick(Sender: TObject);
begin
  filtrarTodos;
end;

procedure TForm_ConsultarProduto.SpeedButton_limparConsultaClick
  (Sender: TObject);
begin
   limpaGrid;
end;

procedure TForm_ConsultarProduto.SpeedButton_VoltarClick(Sender: TObject);
begin
  Close;
end;

end.
