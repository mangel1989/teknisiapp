-- TEKNISIAPP - SKEMA AWAL
CREATE TABLE cabang (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama TEXT NOT NULL,
  alamat TEXT,
  lat FLOAT,
  lng FLOAT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  pass_hash TEXT NOT NULL,
  role TEXT CHECK (role IN ('admin','owner','teknisi')) DEFAULT 'teknisi',
  cabang_id UUID REFERENCES cabang(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE teknisi (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  nama TEXT NOT NULL,
  no_hp TEXT,
  gaji_pokok NUMERIC(12,2) DEFAULT 0,
  tgl_masuk DATE DEFAULT CURRENT_DATE
);

CREATE TABLE barang (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kode TEXT UNIQUE NOT NULL,
  nama TEXT NOT NULL,
  satuan TEXT,
  stok INT DEFAULT 0,
  cabang_id UUID REFERENCES cabang(id) ON DELETE CASCADE
);

CREATE TABLE absen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  teknisi_id UUID REFERENCES teknisi(id) ON DELETE CASCADE,
  tgl DATE NOT NULL,
  jam_masuk TIME,
  jam_pulang TIME,
  selfie_in TEXT,
  selfie_out TEXT,
  lat_in FLOAT,
  lng_in FLOAT,
  lat_out FLOAT,
  lng_out FLOAT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE jadwal (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tgl DATE NOT NULL,
  cabang_id UUID REFERENCES cabang(id) ON DELETE CASCADE,
  teknisi_id UUID REFERENCES teknisi(id) ON DELETE SET NULL,
  pelanggan TEXT,
  alamat TEXT,
  lat_pelanggan FLOAT,
  lng_pelanggan FLOAT,
  status TEXT CHECK (status IN ('pending','proses','selesai')) DEFAULT 'pending',
  created_by UUID REFERENCES users(id)
);

CREATE TABLE kasbon (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  teknisi_id UUID REFERENCES teknisi(id) ON DELETE CASCADE,
  tgl DATE NOT NULL,
  jumlah NUMERIC(12,2) NOT NULL,
  keterangan TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
