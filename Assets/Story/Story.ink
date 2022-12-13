VAR mission_index = 1
VAR accepted_evil_proposal = false
VAR delivered_fake_package = false
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
      -3: -> third_mission
      -else:
      ->END
    }
= first_mission
{ stopping: 
    - -> first_mission_start
    - -> delivery_in_progress
}
= second_mission
{ stopping: 
    - -> second_mission_start
    - -> delivery_in_progress 

}

= third_mission
{ stopping: 
    - -> third_mission_start
    - -> delivery_in_progress 
}

= third_mission_start
    Jaimo: Ah, está de volta novamente. E aí, e aí, como era a casa do granfino?
    Jaimo: O senhor Raul é um grande investidor da nossa empresa. É melhor ter tratado ele com todo o respeito, ou você vai ver.
    Jaimo: Sem corpo mole. Já tenho uma outra entrega pra você fazer. 
    Jaimo: Vamos ver... É para a dona Alexandrina de novo. Deve ser outro pacote de adubo pro jardim dela.
    Jaimo: Vou te contar, a velhinha tem um jardim de arrasar. Muito bem cuidado. Já até saiu em uma revista ou outra aí, pelo que fiquei sabendo.
    Jaimo: Aqui está. Força, rapaz. Iiih, mas tá fraquinho. Tá precisando comer galinha com quiabo, viu.
    Jaimo: Tudo certo. Essa deve ser sua ultima entrega de hoje. Terminando, passe aqui para bater o ponto.
    Jaimo: E aqui está seu pagamento pela última entrega. 16 reais e como de praxe, a gasolina é por sua conta.
    +[...]
    +[*suspiro*]
    -Jaimo: Olhe pelo lado bom, novato. Você está trabalhando num lugar com um ambiente legal. Somos quase família, não somos?
    Jaimo: Agora vá fazer sua entrega, filho
    ->->

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
= delivery_in_progress 
    Jaimo: O que está fazendo aqui? Vá fazer a entrega, novato.
    ->->
    
=== house_101 ===
->decide_mission
= decide_mission
    {mission_index:
      -1: -> first_mission
      -2: -> second_mission
      -else:
      ->END
    }
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

= third_mission
    Dona Alexandrina: Mas é você de novo. Que ótima supresa.
= second_mission
->no_one_home

== no_one_home
Parece que Dona Alexandrina está ocupada. Melhor voltar mais tarde.
->->

=== house_777 ===
->decide_mission
= decide_mission
    {mission_index:
      -1: -> first_mission
      -2: -> second_mission
      -else:
      ->END
    }
= first_mission
    Parece que não há ninguém em casa no momento.
    ->DONE

= second_mission
{ stopping: 
    - -> second_mission_start
    - -> second_mission_repeat
}

= second_mission_repeat
    Raul: Você de novo por aqui?
    {accepted_evil_proposal:
        Raul: O que está fazendo, entregador? Vá logo se livrar da velha.
        ->->
    - else:
        Raul: Pensou melhor sobre a minha proposta e decidiu voltar?
        +[Não mesmo]
            ->->
        +[Estou ouvindo]
            Raul: Sabia que você era um cara inteligente. Desde que te vi, tive certeza, sim.
            ->accept_proposal
    }

= second_mission_start
    ???: Ora, ora. Mas quem bate na minha porta em plenas 9 da madrugada?
    -(top) ???: Ah, é você... Seja lá quem seja você. O quê quer comigo?
    +[Entrega para você]
    +[Que bicho te mordeu?]
        ???: Tempo é dinheiro e tenho coisas mais pra fazer do que ser educado com um qualquer que aparece na minha porta.
        ->top
    -???: Ah, então é um entregador... Interessante. E suponho que essa seja a minha maleta, não é?
    Raul: Bom, entregador. Meu nome é Raul Borbas Nepomuceno Sevilla de Camarões III. Mas acredito que Raul já sirva para você.
    Raul: Antes de você ir, entregador. O que acha de ganhar um dinheiro extra?
    +[Estou ouvindo...]
    
    +[Não tenho interesse]
        Raul: Nem se eu te oferecer essa maleta que está nas suas mãos?
        Ao abrir a maleta e se depara com inúmeras cédulas de dinheiro novas. Você fica com dificuldade de até mesmo estimar quanto pode haver ali.
        Raul: Centro de cinquenta mil e quinhentos e vinte e três reais. Nada mais e nada menos.
        Raul: E aí, o que me diz?
        ++[Eu topo]
        ++[Não quero. Adeus]
            ->decline_proposal
        - ->accept_proposal
        
    == accept_proposal
    Raul: Então, com o verão chegando, acontece que eu quero presentear uma pessoa especial com um belo PISCINÃO.
    Raul: E essa pessoa especial não é ninguém menos do que EU!
    Raul: Pois bem, acontece que aqui nessa rua tem um lugar absolutamente PER-FEI-TO para construir minha piscina, com uma incidência perfeita de sol no alto da tarde e aquele delicioso ventinho de fim de tarde.
    Raul: Mas infelizmente, atualmente tem uma casa horrenda, de uma velha cabeça dura justamente onde quero construir minha piscina.
    Raul: Você deve ter conhecido a velha do 101 durante as suas entregas, certo? Dona Cotinha ou algo do tipo. Então, ela quem está entre mim e meu merecido verão. 
    Raul: Eu já tentei de todas as formas comprar a casa dela, mas a velhinha é teimosa e não quer abrir mão da casa. Nem mesmo por todo dinheiro do mundo. Acredite, eu tentei.
    Raul: Ai que você entra, entregador. Você vai me ajudar a expulsar ela de lá. E eu tenho o plano perfeito pra isso.
    Raul: Pegue este pacote. Um passarinho me contou que a boa velhinha está esperando um adubo novo pra jardim que ela tanto ama.
    Raul: Quem melhor do que um entregador para trocar a entrega por um adubo nem-um-pouco-adulterado e com certeza de melhor qualidade, não é mesmo?
    Raul: Agora vá e não se demore.
    ~ complete_delivery()
    ~accepted_evil_proposal = true
        ->->
        
    == decline_proposal
        Raul: Uma pena. Mas saiba que a oferta ainda está de pé. Volte aqui quando quiser falar de negócios, entregador.
        ~ complete_delivery()
        ->->
        
 
    


