import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id:window
    visible: true
    width: 640
    height: 460
    color: "white"
    title: qsTr("Hello World")
    opacity: 1

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
            width: parent.width
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
        height: parent.height * .1 + 10
        width: parent.width;
        anchors.centerIn: parent
        //        x: (parent.width / 2 ) - (width /2 )
        //        y: (parent.height / 2 ) - (height /2 )
        color: "gray"
        opacity: .5
        border.width: window.width *.01
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
            font.pixelSize: parent.width * .09
            id :txtstart
            text: "3"
        }
        //}


        Rectangle{
            id : coca
            visible : false;
            width: parent.height
            height: width
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
        property int  counter: 10;
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
                }else if(tube.width /2 == (coca.x +( coca.width / 2 ))){
                    console.log("Tie");
                }else{
                    p1_win = false
                    console.log("P1 win" +(coca.x +( coca.width / 2 )) +"width : " + window.width );
                }

            }else{
                mscounter.running = true ;
                txtCouter.text = counter
            }
        }
    }

        NumberAnimation {
            id:showCount
            target: circle
            property: "opacity"
            duration: 2000
            from:0
            to : .7
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


    property int count_P1: 0;
    property int count_P2: 0;
    property bool p1_win : null
    Item{
        focus:true;
        Keys.onPressed:
            if(counterTime.running && counterTime.counter != 0 && txtMicroSec.text !='000'){
                switch(event.key){
                case Qt.Key_Left:
                case Qt.Key_Right:
                    coca.x = coca.x -  (window.width /50);
                    count_P1 ++ ;
                    console.log("coca : " + coca.x  + "window : "+ window.width);
                    if(coca.x >= (window.width - coca.width) ){
                        p1_win = true
                        console.log("P1 win ");
                    }
                    break;
                case Qt.Key_A :
                case Qt.Key_D:
                    coca.x = coca.x + (window.width /50);
                    count_P2 ++ ;

                    console.log("coca : " + coca.x  + "window : "+ window.width);
                    if(coca.x <= 0){
                        p1_win  = false
                        console.log("P2 win ");
                    }
                    break;
                case Qt.Key_Escape:

                }
            }
    }
}
