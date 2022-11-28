
Jaimo: Ah, que belo dia. Um solzão desses pede uma birita no fim do expediente.
Jaimo: E aí, novato. Preparado para seu primeiro dia como estregador?
*[Estou nervoso]
Jaimo: Pode ficar tranquilo, meu jovem. 
-> introduction_first_mission
*[Estou muito ansioso]
Jaimo: Esse é o espírito, meu jovem!
-> introduction_first_mission

=== introduction_first_mission ===
Jaimo: Pois vejamos. A sua rota é a Rua das Graviolas...
Jaimo: Deu muita sorte. Essa é uma rua [...]. Será uma rota muito tranquila.
Jaimo: Sua primeira entrega será na Casa 101. Leve este pacote para a sra. Alexandria.
->first_mission
-> DONE

=== first_mission ===
*[Ir para casa 101]
->first_mission_house_101
*[Ir para casa 777]
->first_mission_house_777

=== first_mission_house_101 ===
Sra. Alexandria: Ó, mas que belo jovemzinho. Você lembra muito do Thomas. Um excelente rapazinho, ele era.
->delivery_branch

= delivery_branch
Sra. Alexandria: No que posso ajudá-lo?
*[Entrega para a senhora]
->first_mission_house_101.delivery_continue
+[Quem é Thomas?]
->first_mission_house_101.asked_thomas

= asked_thomas
Sra. Alexandria: Thomas era meu filho. Ele faleceu no ano passado em um acidente de carro.
Sra. Alexandria: Ele era a luz da minha vida. Um presente dos céus.
Sra. Alexandria: Como sinto sua falta, meu filho.
->first_mission_house_101.delivery_branch
= delivery_continue
Sra. Alexandria: Ah, devem ser a batedeira que pedi pela Tramazon™. Finalmente poderei fazer minhas tortas novamente.
Sra. Alexandria: Volte aqui mais tarde para um pedaço de torta, meu querido. Tenha um ótimo dia.
->first_mission_checkout
->DONE

=== first_mission_house_777 ===
Parece que não há ninguém em casa no momento.
-> DONE

=== first_mission_checkout ===
Jaimo: Você está de volta. E ai, como foi a primeira entrega?
Jaimo: Para agora, você tem duas entregas a fazer. Uma na casa 102 e a outra... Uau! Na casa 777.
Jaimo: O cara da casa 777 é um granfino da maior alta classe. A entrega, aparentemente é essa maleta preta. 
Jaimo: Seja lá o que tiver aí, deve custar horrores. Comece levando isso e nem pensar em passar a mão, hein!
Jaimo: Depois disso, leve o pacote do 102. O cara é um militar, então cuidado com o que fala com ele.
Jaimo: Ah, pera aí. Quase esqueci. Aqui está seu pagamento pela entrega anterior. Deu 5 reais.
* [Só isso!?]
-> first_mission_checkout.payment_received
* [Isso é muito pouco...]
-> first_mission_checkout.payment_received
= payment_received
Jaimo: Bom, não há nada que eu possa fazer. É o valor que a empresa paga. Agora saia daqui e vá fazer as entregas.
-> DONE

