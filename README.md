# Sinebox Projesi
Kişisel film arşivinizi yönetmek ve düzenlemek için geliştirilmiştir. Özellikle film izlemeyi ve saklamayı sevenlerin en büyük sorunu bir zaman sonra giderek artan ve büyük bir karmaşaya dönüşen film ve klasör topluluğudur. Sinebox düzenli listesi ve içerdiği film bilgileri ile hem filmlerinize sade ve güzel bir arayüz ile erişmenize hem de hızlı bir şekilde arama yapmanıza olanak sunuyor. Ayrıca web tabanlı alt yapısı sayesinde PC, tablet veya cep telefonu üzerinden erişime olanak sağlıyor.

# Kurulum
Sinebox [Vibe.d](http://www.vibed.org/) ile geliştirilmiş olup veritabanı olarak [MongoDB](https://www.mongodb.com/) veritabanını kullanmaktadır. Sinebox sisteminin kurulumuna başlamadan önce MongoDB veritabanının sisteminizde kurulu ve sorunsuz bir şekilde çalıştığından emin olun. Ek olarak, sisteminizde libevent-dev ve libssl-dev paketleri de bulunmalıdır.

Örneğin, bunları Ubuntu gibi Debian temelli bir sistemde aşağıdaki komutlarla kurabilirsiniz:

  ```
    sudo apt-get install mongodb
    sudo apt-get install libevent-dev
    sudo apt-get install libssl-dev
  ```

Github üzerindeki depoyu klonlayarak veya zip dosyası olarak sisteminize indirdikten sonra sinebox klasörüne geçin ve önce
  ```d
    dub build
  ```
komutunu çalıştırın. Herhangi bir hata olmadan işlem sonlandıysa
  ```d
    dub run
  ```
komutunu çalıştırarak sistemi başlatabilirsiniz.

dub run komutu başarılı bir şekilde kodları derleyip projeyi çalıştırdıktan sonra Sinebox arayüzü için http://127.0.0.1:8080 adresini ziyaret edebilirsiniz. İyi eğlenceler! :)
