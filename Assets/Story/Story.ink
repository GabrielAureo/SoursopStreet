VAR mission_index = 1
LIST delivery_status = ON_PROGRESS, DELIVERED
VAR current_delivery_status = ON_PROGRESS
->on_street
=== function complete_current_mission ===
    ~ mission_index = mission_index + 1
    ~ current_delivery_status = ON_PROGRESS
=== function complete_delivery ===
    ~ current_delivery_status = DELIVERED
=== on_street ===
#movement_choice
+ [go to delivery company] -> delivery_company -> on_street
+ [go to house 101] -> house_101 -> on_street
+ [go to house 777] -> house_777 -> on_street
=== delivery_company ===
<>
{current_delivery_status == DELIVERED:
    ~complete_current_mission()
}
-> decide_mission
= decide_mission
    {mission_index:
      -1: -> first_mission
      -2: -> second_mission
      -else:
      ->END
    }
= first_mission
{ stopping: 
    - -> first_mission_start
    - -> during_first_mission
}
= second_mission
{ stopping: 
    - -> second_mission_start
    - -> during_first_mission
}
= second_mission_start
    Jaimo: Você está de volta. E ai, como foi a primeira entrega?
    Jaimo: Para agora, você tem duas entregas a fazer. Uma na casa 102 e a outra... Uau! Na casa 777.
    Jaimo: O cara da casa 777 é um granfino da maior alta classe. A entrega, aparentemente é essa maleta preta. 
    Jaimo: Seja lá o que tiver aí, deve custar horrores. Comece levando isso e nem pensar em passar a mão, hein!
    Jaimo: Depois disso, leve o pacote do 102. O cara é um militar, então cuidado com o que fala com ele.
    Jaimo: Ah, pera aí. Quase esqueci. Aqui está seu pagamento pela entrega anterior. Deu 5 reais.
    * [Só isso!?]
    * [Isso é muito pouco...]
    -Jaimo: Bom, não há nada que eu possa fazer. É o valor que a empresa paga. Agora saia daqui e vá fazer as entregas.->->
= first_mission_start 
    Jaimo: Ah, que belo dia. Um solzão desses pede uma birita no fim do expediente.
    Jaimo: E aí, novato. Preparado para seu primeiro dia como estregador?
    *[Estou nervoso]
        Jaimo: Pode ficar tranquilo, meu jovem. 
    *[Estou muito ansioso]
        Jaimo: Esse é o espírito, meu jovem!
    - Jaimo: Pois vejamos. A sua rota é a Rua das Graviolas...
    Jaimo: Deu muita sorte. Essa é uma rua [...]. Será uma rota muito tranquila.
    Jaimo: Sua primeira entrega será na Casa 101. Leve este pacote para a sra. Alexandrina. ->->
= during_first_mission 
    Jaimo: O que está fazendo aqui? Vá completar sua missão!
    ->->
=== house_101 ===
= first_mission
    Dona Alexandrina: Ó, mas que belo jovemzinho. Você lembra muito do Thomas. Um excelente rapazinho, ele era.
    - Sra. Alexandrina: No que posso ajudá-lo?
    +[Entrega para a senhora]
    
    *[Quem é Thomas?]
       Dona Alexandrina: Thomas era meu filho. Ele faleceu no ano passado em um acidente de carro.
        Dona Alexandrina: Ele era a luz da minha vida. Um presente dos céus.
        Dona Alexandrina: Como sinto sua falta, meu filho.
    
    - Dona Alexandrina: Ah, devem ser a batedeira que pedi pela Tramazon™. Finalmente poderei fazer minhas tortas novamente.
    Dona Alexandrina: Volte aqui mais tarde para um pedaço de torta, meu querido. Tenha um ótimo dia.
    ~ complete_delivery()
    ->->

== no_one_home
Parece que Dona Alexandrina está ocupada. Melhor voltar mais tarde.
->DONE

=== house_777 ===
= first_mission
Parece que não há ninguém em casa no momento.
->->


