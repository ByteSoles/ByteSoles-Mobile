# ByteSoles
### Anggota kelompok C13:
* 2306240162 - Farhan Adelio Prayata
* 2306275512 - Yovan Raju
* 2306245056 - Daffa Aqil Mahmud
* 2306245756 - Tarissa Mutia Andini
* 2306245680 - Rajendra Rifqi Baskara

## About ByteSoles
&emsp;Kami memperkenalkan ByteSoles sebuah platform e-commerce inovatif yang khusus menyediakan berbagai sepatu sneakers dari merek-merek ternama seperti Adidas, Nike, Puma, dan Vans. Berawal dari pengamatan kami sebagai mahasiswa terhadap tren fashion di Jakarta, kami melihat minat yang tinggi terhadap sneakers sebagai bagian dari gaya hidup urban. Sayangnya, banyak konsumen yang tertipu dengan harga murah oleh penjual di media sosial yang mengklaim produk mereka asli, sering menggunakan istilah seperti "barang bal" atau "barang reject pabrik," padahal keaslian produk tersebut tidak terjamin. Melalui ByteSoles Jakarta, kami berinisiatif untuk menghubungkan konsumen langsung dengan produk asli dari distributor resmi, memberikan kemudahan akses dan pilihan produk yang beragam.

&emsp;Mengapa berbelanja di Jakarta melalui ByteSoles Jakarta? Jakarta, sebagai ibu kota dan pusat bisnis Indonesia, menawarkan berbagai keuntungan unik. Kota ini sering menjadi tempat peluncuran pertama produk-produk terbaru dari merek-merek internasional, sehingga pelanggan mendapatkan akses lebih cepat ke koleksi terbaru dan edisi terbatas. Pengiriman dalam kota lebih cepat dan efisien dengan biaya lebih rendah, layanan jual lebih mudah, dan adanya event serta promosi lokal yang eksklusif bagi komunitas sneakers di Jakarta. Dengan maraknya penipuan online, ByteSoles Jakarta memberikan solusi dengan menjamin keaslian setiap produk, sehingga konsumen tidak perlu khawatir tertipu oleh penawaran yang tidak jelas di media sosial.

&emsp;Kebermanfaatan aplikasi ini meliputi kemudahan akses bagi pengguna untuk berbelanja kapan saja dan di mana saja, jaminan keaslian produk melalui kerja sama dengan distributor resmi, serta transaksi yang aman dan mudah. Dengan layanan pelanggan yang responsif dan komunitas sneakers yang aktif, ByteSoles Jakarta tidak hanya menyediakan platform belanja yang terpercaya dan user-friendly, tetapi juga berkontribusi positif bagi komunitas pecinta sneakers di Jakarta. Kami bertujuan untuk melindungi konsumen dari praktik penipuan dan ketidakpastian yang sering terjadi di platform media sosial, dengan menyediakan sumber terpercaya untuk kebutuhan sneakers Anda.

## Modules
1. **Registrasi dan Autentikasi Pengguna**  (TIDAK DIHITUNG)
    * Registrasi akun baru
    * *Login*
    * *Logout*
    * Pengaturan ulang kata sandi dengan verifikasi email atau nomor telepon
2. **Detail Produk**  
    * Menampilkan detail informasi produk 
    * Menampilkan pilihan untuk membeli langsung atau menyimpan ke keranjang
3. **Profil Pengguna**  
    * Menampilkan informasi *user* yang sedang *login*
    * Memungkinkan *user* untuk mengedit informasi mereka (alamat email, nomor telepon, etc.)
4. **Katalog Produk**  
    * Menampilkan daftar lengkap *sneakers* berdasarkan kategori:
        * Merek
        * Deskripsi detail
        * Harga
    * Fitur *filter* untuk menampilkan produk berdasarkan kategori yang dipilih
5. **Keranjang Belanja**  
    * Memungkinkan *user* untuk:
        * Menambahkan produk ke keranjang
        * Mengubah jumlah produk yang berada di keranjang
        * Setelah *checkout*, produk yang dibeli dihapus dari keranjang
6. Review dan Rating Produk
    * *User* dapat memberikan ulasan dan rating pada produk yang telah dibeli untuk membantu pelanggan lain dalam membuat keputusan

## Dataset
https://www.kaggle.com/datasets/ajiaron/stockx-sneaker-data

## Role
1. **Admin**
    * *Admin* dapat menambahkan/mengedit objek produk dan detail masing-masing produk sesuai dengan dataset
2. **Guest**
    * *Guest* dapat menelusuri produk-produk dalam aplikasi, tetapi setiap tidak dapat menambahkan produk ke keranjang atau membeli produk. Jika *guest* mencoba untuk melakukan hal tersebut, maka akan muncul popup atau notifikasi untuk *login*.
3. **User**
    * *User* yang berhasil melakukan registrasi akun akan berkesempatan untuk menulusuri produk-produk dan juga menggunakan setiap fitur yang terdapat pada aplikasi ByteSoles (*user* dapat menambahkan produk ke kranjang dan juga membeli produk).


