let Namespace = "MYRISCVX" in {
  class MYRISCVXReg<bits<5> Enc, string n, list<string> alt = []> : Register<n> {
    let HWEncoding{4-0} = Enc;
    let AltNames = alt;
  }

  class MYRISCVXGPRReg<bits<5> Enc, string n, list<string> alt = []> : MYRISCVXReg<Enc, n, alt>;

  def ZERO : MYRISCVXGPRReg<0,  "x0", ["zero"]>,  DwarfRegNum<[0]>;

  def RA   : MYRISCVXGPRReg<1,  "x1", ["ra"]>,    DwarfRegNum<[1]>;
  def SP   : MYRISCVXGPRReg<2,  "x2", ["sp"]>,    DwarfRegNum<[2]>;
  def GP   : MYRISCVXGPRReg<3,  "x3", ["gp"]>,    DwarfRegNum<[3]>;
  def TP   : MYRISCVXGPRReg<4,  "x4", ["tp"]>,    DwarfRegNum<[4]>;
  def T0   : MYRISCVXGPRReg<5,  "x5", ["t0"]>,    DwarfRegNum<[5]>;
  def T1   : MYRISCVXGPRReg<6,  "x6", ["t1"]>,    DwarfRegNum<[6]>;
  def T2   : MYRISCVXGPRReg<7,  "x7", ["t2"]>,    DwarfRegNum<[7]>;
  def FP   : MYRISCVXGPRReg<8,  "x8", ["s0", "fp"]>, DwarfRegNum<[8]>;  // used as FP
  def S1   : MYRISCVXGPRReg<9,  "x9", ["s1"]>,    DwarfRegNum<[9]>;

  def A0   : MYRISCVXGPRReg<10, "x10", ["a0"]>,   DwarfRegNum<[10]>;
  def A1   : MYRISCVXGPRReg<11, "x11", ["a1"]>,   DwarfRegNum<[11]>;
  def A2   : MYRISCVXGPRReg<12, "x12", ["a2"]>,   DwarfRegNum<[12]>;
  def A3   : MYRISCVXGPRReg<13, "x13", ["a3"]>,   DwarfRegNum<[13]>;
  def A4   : MYRISCVXGPRReg<14, "x14", ["a4"]>,   DwarfRegNum<[10]>;
  def A5   : MYRISCVXGPRReg<15, "x15", ["a5"]>,   DwarfRegNum<[11]>;
  def A6   : MYRISCVXGPRReg<16, "x16", ["a6"]>,   DwarfRegNum<[12]>;
  def A7   : MYRISCVXGPRReg<17, "x17", ["a7"]>,   DwarfRegNum<[13]>;

  def S2   : MYRISCVXGPRReg<18, "x18", ["s2"]>,   DwarfRegNum<[18]>;
  def S3   : MYRISCVXGPRReg<19, "x19", ["s3"]>,   DwarfRegNum<[19]>;
  def S4   : MYRISCVXGPRReg<20, "x20", ["s4"]>,   DwarfRegNum<[20]>;
  def S5   : MYRISCVXGPRReg<21, "x21", ["s5"]>,   DwarfRegNum<[21]>;
  def S6   : MYRISCVXGPRReg<22, "x22", ["s6"]>,   DwarfRegNum<[22]>;
  def S7   : MYRISCVXGPRReg<23, "x23", ["s7"]>,   DwarfRegNum<[23]>;
  def S8   : MYRISCVXGPRReg<24, "x24", ["s8"]>,   DwarfRegNum<[24]>;
  def S9   : MYRISCVXGPRReg<25, "x25", ["s9"]>,   DwarfRegNum<[25]>;
  def S10  : MYRISCVXGPRReg<26, "x26", ["s10"]>,   DwarfRegNum<[26]>;
  def S11  : MYRISCVXGPRReg<27, "x27", ["s11"]>,   DwarfRegNum<[27]>;

  def T3   : MYRISCVXGPRReg<28, "x28", ["t3"]>,   DwarfRegNum<[28]>;
  def T4   : MYRISCVXGPRReg<29, "x29", ["t4"]>,   DwarfRegNum<[29]>;
  def T5   : MYRISCVXGPRReg<30, "x30", ["t5"]>,   DwarfRegNum<[30]>;
  def T6   : MYRISCVXGPRReg<31, "x31", ["t6"]>,   DwarfRegNum<[31]>;
}

let Namespace = "MYRISCVX" in {
  def XLenVT = ValueTypeByHwMode<[RV32, RV64, DefaultMode],
                                 [i32, i64, i32]>;
  def GPR : RegisterClass<"MYRISCVX", [XLenVT], 32, (add
ZERO
,RA ,SP ,GP ,TP

,A0 ,A1 ,A2 ,A3 ,A4 ,A5 ,A6 ,A7

// Calee Saved(呼ばれた関数が上書きしないようにsaveする)
,FP ,S1 ,S2 ,S3 ,S4 ,S5 ,S6 ,S7 ,S8 ,S9 ,S10 ,S11

// Caller Saved(呼び出し元関数が上書きされないようにsaveする)
,T0 ,T1 ,T2 ,T3 ,T4 ,T5 ,T6
)> {
    let RegInfos = RegInfoByHwMode<[RV32, RV64, DefaultMode],
                                   [RegInfo<32, 32, 32>, RegInfo<64, 64, 64>, RegInfo<32, 32, 32>]>;
  }
}

