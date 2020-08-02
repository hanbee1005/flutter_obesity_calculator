import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // TextField의 현재 값을 얻는 데 필요 (TextField 위젯 수에 맞게 준비)
  final myController = TextEditingController();

  // Form 위젯에 유니크한 키 값을 부여하고 검증시 사용
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // addListener로 상태를 모니터링할 수 있음
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // 화면이 종료될 때는 반드시 위젯 트리에서 컨트롤러를 해제해야 함
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    // 컨트롤러의 text 프로퍼티로 연결된 TextField에 입력된 값을 얻음
    print('두 번째 text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Input 연습'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) { // 텍스트 변경 감지 이벤트
                print('첫 번째 text field: $text');
              },
            ),
            TextField(
              controller: myController, // 컨트롤러를 지정
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return '글자를 입력하세요';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // 폼을 검증하여 통과하면 true, 실패하면 false 리턴
                        if (_formKey.currentState.validate()) {
                          // 검증이 통과하면 스낵바 표시
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('검증 완료'),));
                        }
                      },
                      child: Text('검증'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
