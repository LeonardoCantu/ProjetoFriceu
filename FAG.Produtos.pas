unit FAG.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm_Produtos = class(TForm)
    DBGrid1: TDBGrid;
    Mem_Produtos: TFDMemTable;
    ds_Produtos: TDataSource;
    Edit_Pesquisa: TEdit;
    Label1: TLabel;
    SpeedButton_Filtrar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton_FiltrarClick(Sender: TObject);
    procedure Edit_PesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    function puxarProdutos: Boolean;
  public
    { Public declarations }
  end;

var
  Form_Produtos: TForm_Produtos;

implementation

{$R *.dfm}

uses FAG.DataModule.Conexao;

procedure TForm_Produtos.DBGrid1DblClick(Sender: TObject);
begin
  if Mem_Produtos.IsEmpty then
    ModalResult := mrAbort
  else
    ModalResult := mrOk;
end;

procedure TForm_Produtos.Edit_PesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SpeedButton_Filtrar.Click;
end;

procedure TForm_Produtos.FormShow(Sender: TObject);
begin

  Edit_Pesquisa.SetFocus;

  puxarProdutos;

  DBGrid1.Columns[0].FieldName := 'prod_id_produto';
  DBGrid1.Columns[1].FieldName := 'prod_desc';
  DBGrid1.Columns[2].FieldName := 'cat_desc';
  DBGrid1.Columns[3].FieldName := 'un_medida_sigla';
end;

function TForm_Produtos.puxarProdutos: Boolean;
begin
  DataModuleConexao.ExecSQL
    ('SELECT prod_id_produto, prod_desc, cat_desc, un_medida_sigla FROM produto INNER JOIN categoria USING (cat_id_categoria) INNER JOIN un_medida USING (un_medida_id) ORDER BY prod_id_produto asc',
    Mem_Produtos);
end;

procedure TForm_Produtos.SpeedButton_FiltrarClick(Sender: TObject);
begin
  DataModuleConexao.ExecSQL
    ('SELECT prod_id_produto, prod_desc, cat_desc, un_medida_sigla FROM produto INNER JOIN categoria USING (cat_id_categoria) INNER JOIN un_medida USING (un_medida_id) WHERE prod_desc LIKE "%'
    + Edit_Pesquisa.Text + '%"', Mem_Produtos);
end;

end.
