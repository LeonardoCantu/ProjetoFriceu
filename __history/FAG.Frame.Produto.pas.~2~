unit FAG.Frame.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FAG.Produtos;

type
  TFrame_Produto = class(TFrame)
    Edit_descricao: TEdit;
    Image1: TImage;
    Edit_codigoProduto: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    FDMemTable_Produto: TFDMemTable;
    procedure Image1Click(Sender: TObject);
    procedure Edit_codigoProdutoChange(Sender: TObject);

  private
    objPsq: TForm_Produtos;
  public
    constructor Create(AOwner: TComponent); override;

  end;

implementation

uses
  FAG.DataModule.Conexao;

{$R *.dfm}
{ TFrame_Produto }

const
  SQL_PRODUTO: String = 'SELECT * FROM produto ';

constructor TFrame_Produto.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TFrame_Produto.Edit_codigoProdutoChange(Sender: TObject);
var
  fdTmp: TFDMemTable;
  sql: String;
begin
  try
   if (Edit_codigoProduto.Text <> EmptyStr) then
   begin
    sql := SQL_PRODUTO + ' WHERE prod_id_produto =' + Edit_codigoProduto.Text;
    DataModuleConexao.ExecSQL(sql, FDMemTable_Produto);
    Edit_descricao.Text := FDMemTable_Produto.FieldByName
      ('prod_desc').AsString;
    Edit_codigoProduto.Text := FDMemTable_Produto.FieldByName
      ('prod_id_produto').AsString;

   end;
   if Trim(Edit_codigoProduto.Text) = EmptyStr then
   begin
    Edit_descricao.Clear;
   end;
   except
    Application.MessageBox ('Informe apenas números','Erro',MB_OK+MB_ICONEXCLAMATION);
    Edit_codigoProduto.Clear;
    Edit_codigoProduto.SetFocus;
  end;
end;


procedure TFrame_Produto.Image1Click(Sender: TObject);
var
  sql: String;
begin
  objPsq := TForm_Produtos.Create(Self);
  try
    if objPsq.ShowModal = mrOk then
    begin
      Edit_codigoProduto.Text := objPsq.Mem_Produtos.FieldByName
        ('prod_id_produto').AsString;
      Edit_descricao.Text := objPsq.Mem_Produtos.FieldByName
        ('prod_desc').AsString;
      sql := 'SELECT * FROM produto WHERE prod_id_produto = ' +
        objPsq.Mem_Produtos.FieldByName('prod_id_produto').AsString;
      DataModuleConexao.ExecSQL(sql, FDMemTable_Produto);
    end
    else
    begin
      Edit_codigoProduto.Clear;
      Edit_descricao.Clear;
      try
        FDMemTable_Produto.EmptyDataSet;
      except

      end;
    end;
  finally
    FreeAndNil(objPsq);
  end;
end;

end.
