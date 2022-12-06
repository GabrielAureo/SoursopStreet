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
    Jaimo: Depois disso, leve o pacote do 102. O cara é um veterano de guerra, então cuidado com o que fala com ele.
    Jaimo: Ah, pera aí. Quase esqueci. Aqui está seu pagamento pela entrega anterior. Deu 3 reais e a gasolina é por sua conta.
    * [Só isso!?]
    * [Isso é escravidão...]
    -Jaimo: Bom, não há nada que eu possa fazer. É o valor que a empresa paga. Agora saia daqui e vá fazer as entregas.->->
= first_mission_start 
    Jaimo: Ah, que belo dia. Um solzão desses só uma gelada, né não?
    Jaimo: E aí, novato. Preparado para seu primeiro dia como jovem aprendiz?
    *[Estou nervoso]
        Jaimo: Pode ficar tranquilo, meu jovem. 
    *[Estou muito ansioso]
        Jaimo: Esse é o espírito, meu jovem!
    - Jaimo: Você é um cara de sorte por vestir a camisa da Tramazon. Aqui nós somos mais do que uma equipe, somos família.
    Jaimo: Mas vamos aos negócios. A sua rota é a Rua das Graviolas...
    Jaimo: Deu muita sorte. Essa é uma rua tradicional da cidade. Será uma rota muito tranquila, pode confiar.
    Jaimo: Sua primeira entrega será na Casa 101. Leve este pacote para a sra. Alexandrina. ->->
= during_first_mission 
    Jaimo: O que está fazendo aqui? Vá fazer a entrega, novato.
    ->->
=== house_101 ===
= first_mission
    Dona Alexandrina: Ó, mas que belo jovemzinho na minha porta. Você lembra muito do Thomas. Um excelente rapazinho, ele era.
    -(top) Dona Alexandrina: No que posso ajudá-lo?
    +[Entrega para a senhora]
    
    *[Quem é Thomas?]
       Dona Alexandrina: Thomas era meu filho. Ele faleceu no ano passado em um acidente de carro.
        Dona Alexandrina: Ele era a luz da minha vida. Um presente dos céus. Como sinto sua falta, meu filhinho...
        Dona Alexadrina: Perdão por tomar seu tempo, jovemzinho.
        ->top
    - Dona Alexandrina: Ah, devem ser a batedeira que a minha irmã tirou pra mim. Finalmente poderei fazer minhas tortas novamente.
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


