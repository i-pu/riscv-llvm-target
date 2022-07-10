# isa の概要

- 命令手・命令の表現形式・機械語
- 汎用レジスタ仕様
- メモリアドレッシング仕様
- 仮想メモリ仕様
- 割り込み・例外仕様
- デバッグ仕様

```risc-v
# reg[x10] := reg[x11] + reg[x12]
add x10, x11, x12

# reg[x20] := mem[reg[x15] + 0x8]
lw x20, 0x8(x15)

# reg[x11] < reg[12] => reg[x10] := 1
# reg[x11] >= reg[12] => reg[x10] := 0
slt x10, x11, x12
# reg[x11] < 100 => reg[x10] := 1
# reg[x11] >= 100 => reg[x10] := 0
slti x10, x11, 100

# reg[x10] == reg[x11] => pc := pc + 0x100
beq x10, x11, 0x100

# pc := 0x100
j 0x100

# pc := reg[x10]
jr x10

# link regsiter := pc + 1addr
# pc := reg[x10]
jal 0x100

# reg[x11] := mem[reg[x20]]
# reg[x20]はalignされていなければいけない
lw x11, 0(x20)
lh x11, 0(x20)
lb x11, 0(x20)

# mem[reg[x20]] := reg[x11][下位nbit]
# reg[x20]はalignされていなければいけない
sw x11, 0(x20)
sh x11, 0(x20)
sb x11, 0(x20)
```

RISC-V の命令セットは自分で必要なものを選ぶことができ，
基本命令セット 1 つに拡張命令セットを複数選択して命令セットを選ぶ．
`RV64IMAFDZicsr_Zifencei`はよく使われるパターンなので`RV64G`と呼ばれる．
`RV64G`に compress 命令が加わった`RV64GC`も合わせて多くの cpu でサポートされている．

# ABI

Application Binary Interface

RISC-V が利用できる ABI は psABI(processor specific ABI)がある．
https://github.com/riscv-non-isa/riscv-elf-psabi-doc

ABI が規定しているもの

- 関数を呼び出す際の引数の渡し方や戻り値の返し方
- OS が使用するシステムコールの呼び出し方
- 実行バイナリのフォーマット

# rtl シミュレーション

register transfer level
クロック毎に動かすようなシミュレーション

# LLVM IR からアセンブリ

LLVM IR -> SelectinDAG -> MachineInstr -> MCInst -> バイナリ

- LLVM IR から SelectionDAG に変換する．命令の依存やレジスタの依存関係を表現する．
- Legalize
  - LLVM での型や命令にはバックエンドが対応できないものも含まれるため，それを同じ動作になるように別の LLVM の型や命令で置き換える
- Instruction Selection
  - LLVM の型や命令を実際のバックエンドの命令に変換する．変換のテーブルは td(target description) ファイルに記述する．
- SelectionDAG から MachineInstr というデータ形式に変換する．MachineInstr はより機械語に近い表現である．
- TODO MachineInstr から MCInst に変換する．
- MCInst から object ファイルか実行可能ファイルに変換する．
