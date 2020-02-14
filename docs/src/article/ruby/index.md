# エピソード1

# Hello World

## 仕様

## 設計

### TODOリスト

  - ❏ TODO

  - ✓ TODO DONE

### ユースケース図

    left to right direction
    skinparam packageStyle rectangle
    actor customer
    actor clerk
    rectangle checkout {
      customer -- (checkout)
      (checkout) .> (payment) : include
      (help) .> (checkout) : extends
      (checkout) -- clerk
    }

### クラス図

    class Car
    Driver - Car : drives >
    Car *- Wheel : have 4 >
    Car -- Person : < owns

### シーケンス図

    participant User
    User -> A: DoWork
    activate A
    A -> B: << createRequest >>
    activate B
    B -> C: DoWork
    activate C
    C --> B: WorkDone
    destroy C
    B --> A: RequestCreated
    deactivate B
    A -> User: Done
    deactivate A

## 開発

## 参照

  - [PlantUML](http://plantuml.com)

## エピソード2

# Fizz Buzz

## 仕様

### Api

1 から 100 までの数をプリントするプログラムを書け。

ただし 3 の倍数のときは数の代わりに｢Fizz｣と、5 の倍数のときは｢Buzz｣とプリントし、

3 と 5 両方の倍数の場合には｢FizzBuzz｣とプリントすること。

タイプごとに出力を切り替えることができる。

タイプ１は通常、タイプ２は数字のみ、タイプ３は FizzBuzz の場合のみをプリントする。

### クライアント

1から100までを１件ずつ画面に表示できる。

1から100まで表示された内容を表示できる。

## 設計

### TODOリスト

#### Api

  - ✓ タイプ1の場合

  - ✓ 数を文字列にして返す

  - ✓ 1を渡したら文字列"1"を返す

  - ✓ 2を渡したら文字列"2"を返す

  - ✓ 3 の倍数のときは数の代わりに｢Fizz｣と返す

  - ✓ 3を渡したら文字列"Fizz"を返す

  - ✓ 5 の倍数のときは｢Buzz｣と返す

  - ✓ 5を渡したら文字列"Buzz"を返す

  - ✓ 3 と 5 両方の倍数の場合には｢FizzBuzz｣と返す

  - ✓ 15を渡したら文字列"FizzBuzz"を返す

  - ✓ タイプ2の場合

  - ✓ 数を文字列にして返す

  - ✓ 1を渡したら文字列"1"を返す

  - ✓ 2を渡したら文字列"2"を返す

  - ✓ 3 の倍数のときは数を文字列にして返す

  - ✓ 3を渡したら文字列"3"を返す

  - ✓ 5 の倍数のときは数を文字列にして返す

  - ✓ 5を渡したら文字列"5"を返す

  - ✓ 3 と 5 両方の倍数の場合には数を文字列にして返す

  - ✓ 15を渡したら文字列"15"を返す

  - ✓ タイプ3の場合

  - ✓ 数を文字列にして返す

  - ✓ 1を渡したら文字列"1"を返す

  - ✓ 2を渡したら文字列"2"を返す

  - ✓ 3 の倍数のときは数を文字列にして返す

  - ✓ 3を渡したら文字列"3"を返す

  - ✓ 5 の倍数のときは数を文字列にして返す

  - ✓ 5を渡したら文字列"5"を返す

  - ✓ 3 と 5 両方の倍数の場合には｢FizzBuzz｣と返す

  - ✓ 15を渡したら文字列"FizzBuzz"を返す

  - ✓ それ以外のタイプの場合

  - ✓ 例外を返す

#### クライアント

  - ✓ カウンター画面

  - ✓ 画面イメージを作る

  - ✓ APIサービスを作る

  - ✓ APIサービスと連携するクライアントサービスを作る

  - ✓ 正常系を実装する

  - ✓ UIを作る

  - ✓ UIとクライアントサービスを連携する

  - ✓ 一覧表示画面

  - ✓ 画面イメージを作る

  - ✓ APIサービスを作る

  - ✓ APIサービスと連携するクライアントサービスを作る

  - ✓ 正常系を実装する

  - ✓ UIを作る

  - ✓ UIとクライアントサービスを連携する

### ユースケース図

### クラス図

    package Application {
      package Service {
        class FizzBuzzService {
          String generate()
          String generate_list()
        }
        interface FizzBuzzCommand {
          execute()
        }
    
        class FizzBuzzValueCommand {
          FizzBuzzType type
          FizzBuzzValue execute()
        }
    
        class FizzBuzzListCommand {
          FizzBuzzType type
          FizzBuzzList execute()
        }
      }
    }
    
    package Domain {
        package Model {
          class FizzBuzzValue {
            Integer number
            String value
            boolean eql()
          }
    
          class FizzBuzzList {
            MAX_COUNT = 100
            ArrayList list
            FizzBuzzList add()
          }
        }
    
        package Type {
          class FizzBuzzType {
            TYPE_01 = 1
            TYPE_02 = 2
            TYPE_03 = 3
            FizzBuzzType {static} create()
            Boolean is_fizz()
            Boolean is_buzz()
            String generate()
          }
    
          class FizzBuzzType01 {
            String generate()
          }
    
          class FizzBuzzType02 {
            String generate()
          }
    
          class FizzBuzzType03 {
            String generate()
          }
        }
    }
    
    package Presentation {
      class FizzBuzzApiService {
        apiUrl
        generate()
        generateList()
      }
    
      class FizzBuzzView {
        _service
        _counterComponent
        _tableComponent
        render()
      }
    
      class FizzBuzzCounterComponent {
        _service
        _conter
        _value
        incrementEvent()
        decrementEvent()
        render()
      }
    
      class FizzBuzzTableComponent {
        _service
        _list
        _type
        changeEvent()
        render()
      }
    }
    
    FizzBuzzService -> FizzBuzzCommand
    FizzBuzzCommand <|-- FizzBuzzValueCommand
    FizzBuzzCommand <|-- FizzBuzzListCommand
    FizzBuzzCommand *- FizzBuzzType
    FizzBuzzType <|-- FizzBuzzType01
    FizzBuzzType <|-- FizzBuzzType02
    FizzBuzzType <|-- FizzBuzzType03
    FizzBuzzType -> FizzBuzzValue
    FizzBuzzListCommand --> FizzBuzzList
    FizzBuzzService <--- FizzBuzzApiService
    FizzBuzzApiService --* FizzBuzzView
    FizzBuzzView *- FizzBuzzCounterComponent
    FizzBuzzTableComponent -* FizzBuzzView

### シーケンス図

## 開発

### Application

#### Service

``` ruby
Unresolved directive in fizz_buzz.adoc - include::../../../api/index.rb[]
```

    Unresolved directive in fizz_buzz.adoc - include::../../../api/generate.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/generate_list.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/application/service/fizz_buzz_service.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/application/service/fizz_buzz_command.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/application/service/fizz_buzz_list_command.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/application/service/fizz_buzz_value_command.rb[]

### Domain

#### Modle

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/model/fizz_buzz_list.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/model/fizz_buzz_value.rb[]

#### Type

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/type/fizz_buzz_type.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/type/fizz_buzz_type_01.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/type/fizz_buzz_type_02.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/fizz_buzz/domain/type/fizz_buzz_type_03.rb[]

### Presentation

``` javascript
Unresolved directive in fizz_buzz.adoc - include::../../../src/presentation/FizzBuzzApiService.js[]
```

    Unresolved directive in fizz_buzz.adoc - include::../../../src/presentation/FizzBuzzView.js[]

    Unresolved directive in fizz_buzz.adoc - include::../../../src/presentation/FizzBuzzCounterComponent.js[]

    Unresolved directive in fizz_buzz.adoc - include::../../../src/presentation/FizzBuzzTableComponent.js[]

### Test

    Unresolved directive in fizz_buzz.adoc - include::../../../api/test/fizz_buzz/fizz_buzz_list_command_test.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/test/fizz_buzz/fizz_buzz_value_command_test.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../api/test/fizz_buzz/fizz_buzz_service_test.rb[]

    Unresolved directive in fizz_buzz.adoc - include::../../../test/FizzBuzzApiService.test.js[]

## 参照

  - [Asciidoctor](http://asciidoctor.org/)

  - [PlantUML](http://www.plantuml.com)
