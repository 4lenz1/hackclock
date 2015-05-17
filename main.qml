import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick 2.4

ApplicationWindow {
    id:window
    visible: true
    width: 1600
    height: 900
    color: "white"
    title: qsTr("Hello World")
    opacity: 1

    Rectangle{
        anchors.fill: parent
        height: parent.height
        width : parent.width
        Image{
            id: picP1a
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            source: "pic/a1.png"
            //scale : window.height * .0005
            //x: 0
        }
        Image{
            id: picP2a
            source: "pic/a2.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom

        }
        Image{
            id: picP1b
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            source: "pic/b1.png"
        }
        Image{
            id: picP2b
            source: "pic/b2.png"
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            //height : (window.height / window.width )* 9
            //width: window.width  *.25
            //scale: window.height * .0005
            //paintedWidth: window.width / 10 * 2.5
            //x: parent.width -  width
        }


        Rectangle{
            id:circle
            visible: false
            height: parent.height * .1
            width: parent.width -10
            color: "orange"
            //anchors.horizontalCenter: parent
            x: (parent.width / 2 ) - (width /2 )
            y :0
            radius: width *.3
            opacity:  .7

            Rectangle{
                id:timeBar
                color : "Red"
                height: parent.height
                //width: parent.width
                radius: parent.radius
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Behavior on x{
                NumberAnimation{
                    duration: 1000;
                    easing.type: Easing.OutElastic;
                }
            }

            Text{
                id:p1
                text : "P1 " + count_P1

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                font.pixelSize: parent.height * .4
                color :"white"
            }

            Text{
                id:p2
                text : "P2 "+count_P2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height * .4
                color :"white"
            }
            Text{
                id: txtCouter
                anchors.centerIn: parent;
                font.bold : true
                font.pixelSize: parent.height * .5
                text : '60'
                color: "white"
                opacity:  .7
            }
            Text{
                id: txtMicroSec
                property int msNum: 0;
                //            anchors.centerIn: parent;
                //               font.bold : true
                anchors.top: txtCouter.bottom
                anchors.horizontalCenter : parent.horizontalCenter
                font.pixelSize: parent.height * .2
                text : msNum
                color: "white"
                opacity:  .7
            }

            NumberAnimation{
                id: mscounter;
                target: txtMicroSec
                running : false ;
                loops : Animation.Infinite;
                property : 'msNum';
                from:  999
                to : 0
                duration: 1000
            }
            SequentialAnimation{
                id : pump
                running:  false
                ParallelAnimation{
                    NumberAnimation{
                        target: circle
                        running : true ;
                        property : 'scale';
                        from:  1
                        to : .7
                        duration: 200
                    }
                    ColorAnimation{
                        target: circle
                        property :'color'
                        duration: 200
                        to :"darkblue"
                    }
                }
                ParallelAnimation{
                    NumberAnimation{
                        target: circle
                        running : true ;
                        property : 'scale';
                        to : 1
                        duration: 200
                    }
                    ColorAnimation{
                        target: circle
                        property :'color'
                        duration: 200
                        to :"orange"
                    }
                }
            }
        }

        Rectangle{
            id: tube
            height: parent.height * .08
            width: parent.width;
            //anchors.centerIn: parent
                    x: (parent.width / 2 ) - (width /2 )
                    y: (parent.height / 2 ) - (height /2 ) - 40
            color: "gray"
            opacity: .8
            border.width: 2
            z:1

            //        Rectangle{
            //            id:start
            //            color: "black"
            //            width: parent.width
            //            height: parent.height - 10
            //            anchors.centerIn:  parent
            Text{
                anchors.fill: parent
                color : "Red"
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font.pixelSize: parent.height
                id :txtstart
                text: "3"
            }
            //}


            //        Image{
            //            source:"pic/c.png"
            //            scale: window.width * .00025
            //            z:3
            //        }


            Image{
                id : coca
                visible : false;
                //width: parent.height
                // height: width
                source:"pic/c.png"
                //fillMode: Image.PreserveAspectCrop
                scale: tube.height * .0125
                z:3
                x: (parent.width / 2 ) - (width /2 )
                y: (parent.height / 2 ) - (height /2 )
                Behavior on x{
                    NumberAnimation{
                        duration: 1000;
                        easing.type: Easing.OutBack;
                    }
                }
            }
        }


        Timer{
            property int startTime : 3;
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                //-- startTime ;
                if(startTime  > 0 ){
                    txtstart.text = startTime -- ;
                    counterTime.running = false
                    if(startTime == 1){
                        circle.visible = true
                        showCount.start()
                    }

                }else{
                    txtstart.text = 0 ;
                    counterTime.running = true;
                    counterTime.start();
                    anitimeBar.start()
                }

                //txtstart.text =  (startTime >= 0)  ? startTime : 0
            }
        }


        Timer{
            id: counterTime
            property int totaltime: counter;
            property int  counter: 30;
            interval: 1000;
            repeat: true
            running: false

            onTriggered: {

                txtstart.visible = false;
                coca.visible = true;


                pump.running =  ( counter % 3 == 0  )  ? true : false;
                counter -- ;
                //txtCouter.text =  (counter <= 0 ? "Time's up" : counter) ;
                if(counter <= 0 ){
                    txtCouter.text = "Time's up"
                    pump.running = false;
                    mscounter.running = false
                    txtMicroSec.text = '000'
                    counterTime.running = false
                    if( (tube.width /2 ) < (coca.x + (coca.width /2))){
                        console.log("P2 win" + (coca.x +( coca.width / 2 )) +"width : " + window.width )
                        p1_win = true
                        p2_win = false
                        //anitimeBar.duration = 100
                        txtCouter.text="P2 Win"
                    }else if(tube.width /2 == (coca.x +( coca.width / 2 ))){
                        console.log("Tie");
                    }else{
                        p1_win = false
                        p2_win = true
                        //anitimeBar.duration = 100
                        console.log("P1 win" +(coca.x +( coca.width / 2 )) +"width : " + window.width );
                        txtCouter.text="P1 Win"
                    }

                }else{
                    mscounter.running = true ;
                    txtCouter.text = counter
                }
            }
        }
        ParallelAnimation{
            id:showCount
            NumberAnimation {

                target: circle
                property: "opacity"
                duration: 2000
                from:0
                to : .7
            }
            NumberAnimation {
                target: timeBar
                property: "width"
                duration: 2000
                easing.type: Easing.InOutQuad
                from: 0
                to: circle.width

            }

        }

        NumberAnimation {
            id: anitimeBar
            target: timeBar
            property: "width"
            duration: counterTime.totaltime * 1000 + 200
            easing.type: Easing.InOutQuad
            from: timeBar.width
            to: 0
        }
        Rectangle{
            z:4
            id:setting
            visible: false
            color : "Red"
            opacity: .7
            width: parent.width / 3
            height:  parent.height / 3
            anchors.centerIn: parent
            Rectangle{
                id:btnRestart
                color: "lightblue"
                width:parent.width - 10
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height / 2 - 10
                Text{
                    id:txtRestart
                    text: "Restart"
                    anchors.centerIn: parent
                    font.pixelSize: parent.height
                }
                MouseArea{
                    onClicked: console.log("restart")
                }
            }

            Rectangle{
                id:btnExit
                color: "lightblue"
                width:parent.width - 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                height: parent.height / 2 - 10
                Text {
                    id: txtExit
                    text: qsTr("Exit")
                    anchors.centerIn: parent
                    font.pixelSize: parent.height
                }
                MouseArea{
                    onClicked: Qt.quit();
                }
            }


        }
    }

    //        MouseArea{
    //            id :mouseP1
    //            width: window.width / 2
    //            height: window.height
    //            x:window.width /2
    //            y: 0
    //            onPressed: {
    //                if(counterTime.counter != 0 && p1_win === null ){
    //                    console.log("p1 pressed")
    //                    count_P1 ++;
    //                }
    //            }
    //        }
    //        MouseArea{
    //            id :mouseP2
    //            width: window.width / 2
    //            height: window.height
    //            x:0
    //            y: 0
    //            onPressed: {
    //                if(counterTime.counter != 0 && p1_win === null){
    //                    console.log("p2 pressed")
    //                    count_P2 ++;
    //                }
    //            }
    //        }

    //        Text{
    //            id:txtTest
    //            text: point1.x
    //            font.pixelSize: 24
    //            anchors.centerIn: parent
    //            z:4
    //        }

    property int count_P1: 0;
    property int count_P2: 0;
    property bool p1_win : false
    property bool p2_win : false



    Item{
        focus:true;
        Keys.onPressed:
            if((counterTime.running && counterTime.counter != 0 && txtMicroSec.text !='000') && (p1_win  ==  p2_win)){
                console.log("p1_win" + p1_win + "p2_win" + p2_win)
                switch(event.key){

                case Qt.Key_Left:
                case Qt.Key_Right:
                    coca.x = coca.x -  (window.width /50);
                    count_P1 ++ ;
                    console.log("coca : " + coca.x  + "window : "+ window.width);
                    //if(coca.x >= (window.width - coca.width) ){
                    if(coca.x <= 0 ){
                        //if((coca.width /2 ) <= 0) {
                        p1_win = true
                        p2_win = false
                        console.log("P1 win ");
                        counterTime.counter = 0
                        //anitimeBar.duration = 100
                    }

                    break;
                case Qt.Key_A :
                case Qt.Key_D:
                    coca.x = coca.x + (window.width /50);
                    count_P2 ++ ;

                    console.log("coca : " + coca.x  + "window : "+ window.width);
                    if(coca.x >= (window.width - coca.width)){
                        p1_win  = false
                        p2_win = true
                        console.log("P2 win ");
                        counterTime.counter = 0
                        //anitimeBar.duration = 100

                    }
                    break;
                case Qt.Key_Escape:
                    // setting.visible = (setting.visible == false ? true : false)
                    if(setting.visible == false){
                        setting.visible = true
                        anisettingon.start()
                    }else{
                        anisettingoff.start()
                        setting.visible = false
                    }

                }
            }
    }

    NumberAnimation {
        id: anisettingon
        target: setting
        property: "opacity"
        duration: 500
        easing.type: Easing.InOutQuad
        from : 0
        to: .7
    }

    NumberAnimation {
        id: anisettingoff
        target: setting
        property: "opacity"
        duration: 500
        easing.type: Easing.InOutQuad
        from : .7
        to: 0
    }

}
