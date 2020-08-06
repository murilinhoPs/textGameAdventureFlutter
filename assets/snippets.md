## - Como adicionar valores num map:

> Primeiro crie uma variável do tipo Map. Depois disso você diz para ele qual key adiconar e qual seu valor, a key entre [] para dizer em qual posição está o pair key,value

```
Flutter - Dart

- Map<String, dynamic> bla = {};

- bla[key] = value;

- returns bla = {key : value }

```

### Compare maps

> Se o Map não é uma classe que herda Equatable, o dart só consegue compará-los se estiverem como string ou seja, ele compara strings e não maps diretamente

```
item.requiredState.toString() == snapshot.data.toString()

```

##### Como está meu Map<String,dynamic>

> flutter: [{sword: true}, {sword: false, torch: true}, {blood: false}, {blood: true}, {sword: false, fim: true}]
