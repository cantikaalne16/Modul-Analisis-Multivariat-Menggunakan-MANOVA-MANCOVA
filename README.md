# Modul Analisis Multivariat Menggunakan MANOVA dan MANCOVA

## Pengaruh Faktor Demografis dan Dukungan Belajar terhadap Performa Akademik Siswa dengan Metode Analisis MANOVA dan MANCOVA

**Disusun oleh:**  
Cantika Latifatul N.E (24031554023)  
Fawwaz Azri (24031554074)  
Sofia Dwi K. (24031554079)  

**Dosen Pengampu:**  
Dinda Galuh Guminta, M.Stat.

---

## Deskripsi Penelitian

Penelitian ini membahas penerapan **MANOVA** untuk menganalisis perbedaan prestasi akademik siswa pada tiga mata pelajaran, yaitu matematika, sains, dan bahasa Inggris berdasarkan faktor:

- Gender  
- Tingkat pendidikan orang tua  
- Jenis makan siang (indikator sosial-ekonomi)  
- Keikutsertaan kursus persiapan ujian  

Selanjutnya, penelitian juga menerapkan **MANCOVA** dengan mengontrol pengaruh variabel kovariat berupa **nilai bahasa Inggris** untuk melihat apakah pengaruh faktor-faktor tersebut tetap signifikan setelah kemampuan dasar siswa dikendalikan.

---

## Variabel Penelitian

| Simbol | Variabel                      |
|-------:|-------------------------------|
| Y1     | Math Score                   |
| Y2     | Science Score                |
| X1     | Gender                       |
| X2     | Parental Education Level     |
| X3     | Lunch                        |
| X4     | Test Preparation Course      |
| C      | English Score (Covariate)    |

---

## Dataset

Penelitian ini menggunakan dataset **Students Academic Performance** yang diperoleh dari Kaggle. Dataset ini berisi 1.000 data siswa dengan informasi performa akademik dan karakteristik demografis yang relevan untuk analisis multivariat.

🔗 https://www.kaggle.com/datasets/saidaminsaidaxmadov/students-academic-performance-dataset

---

## Metode Analisis

- Multivariate Analysis of Variance (MANOVA)  
- Multivariate Analysis of Covariance (MANCOVA)  

Analisis dilakukan menggunakan bahasa pemrograman **R** dan dipublikasikan melalui **RPubs**.
