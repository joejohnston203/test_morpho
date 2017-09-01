void gen_shape1(){
  TString filename = "shape1.root";
  TFile * myfile = TFile::Open(filename, "RECREATE");
  TTree mytree("shape1", "cns shape tree");

  Float_t x;
  mytree.Branch("x", &x, "x/F");
  Float_t y;
  mytree.Branch("y", &y, "y/F");

  TRandom3 * rd = new TRandom3();

  double sum = 0;
  for(int i=1; i<11; i++){
    sum += i;
  }
  for(int i=1; i<11; i++){
    x = i;
    y = i/sum;
    mytree.Fill();
  }

  mytree.Write();
  myfile->Close();
}
