* Caso seu uid seja diferente de 1000, altere o Dockerfile para o valor correto. 
* Crie a imagem


      docker build -t itau .
    
   

* Em seguida


      docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix itau 

* Referência [http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/]()