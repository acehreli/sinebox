# Sinebox Projesi
Kişisel film arşivinizi yönetmek ve düzenlemek için geliştirilmiştir. Özellikle film izlemeyi ve saklamayı sevenlerin en büyük sorunu bir zaman sonra giderek artan ve büyük bir karmaşaya dönüşen film ve klasör topluluğudur. Sinebox düzenli listesi ve içerdiği film bilgileri ile hem filmlerinize sade ve güzel bir arayüz ile erişmenizi hemde hızlı bir şekilde arama yapmanıza olanak sunuyor. Ayrıca web tabanlı alt yapısı sayesinde PC. tablet veya cep telefonu üzerinden erişime olanak sağlıyor.

# Kurulum
Sinebox [Vibe.d](http://www.vibed.org/) ile geliştirlimiş olup veritabanı olarak [MongoDB](https://www.mongodb.com/) veritabanını kullanmaktadır. Sinebox sisteminin kurulumuna başlamaadn önce sisteminizde MongoDB veritabanını kurulu ve sorunsuz bir şekilde çalıştığına emin olun. 

Github üzerindeki depoyu klonlayerak veya zip dosyası olarak sisteminize indirdikten sonra sinebox klasörüne geçin ve önce
  ```d
    dub build
  ```
komutunu çalıştırın herhangi bir hata olmadan işlem sonlandıysa 
  ```d
    dub run
  ```
komutunu çalıştırarak sistemi başlatabilirsiniz.

dub run komutu başarılı bir şekilde kodları derleyip projeyi çalıştırdıktan sonra simebox arayüzü için http://127.0.0.1:8080 adresini ziyaret edebilirsiniz. İyi eğlenceler :)
