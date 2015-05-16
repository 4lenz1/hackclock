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
        height: parent.height * .2
        width: height
        color: "orange"
        x: (parent.width / 2 ) - (width /2 )
        y :0
        radius: width *.5
        opacity:  .7

        Behavior on x{
            NumberAnimation{
                duration: 1000;
                easing.type: Easing.OutBack;
            }
        }

        Text{
            id:p1
            text : count_P1
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            font.pixelSize: parent.width * .08
            color :"white"
        }

        Text{
            id:p2
            text : count_P2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.width * .08
            color :"white"
        }
        Text{
            id: txtCouter
            anchors.centerIn: parent;
            font.bold : true
            font.pixelSize: parent.width * .2
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
            font.pixelSize: parent.width * .08
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
        height: parent.width * .2 + 10
        width: parent.width;
        anchors.centerIn: parent
        //        x: (parent.width / 2 ) - (width /2 )
        //        y: (parent.height / 2 ) - (height /2 )
        color: "gray"
        opacity: .5
        border.width: window.width *.01
        z:1

        Rectangle{
            id : coca
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
        property int  counter: 10;
        interval: 1000;
        repeat: true
        running: true
        onTriggered: {
            pump.running =  ( counter % 4 == 0  )  ? true : false;
            counter -- ;
            //txtCouter.text =  (counter <= 0 ? "Time's up" : counter) ;
            if(counter <= 0 ){
                txtCouter.text = "Time's up"
                pump.running = false;
                mscounter.running = false
                if( (tube.width /2 ) < coca.x + coca.width){
                    console.log("P1 win" + coca.x + coca.width +"width : " + window.width )
                }else if(tube.width /2 == coca.x + coca.width){
                        console.log("Tie");
                }else{
                    console.log("P2 win");
                }

            }else{
                mscounter.running = true ;
                txtCouter.text = counter
            }
        }
    }

    property int count_P1: 0;
    property int count_P2: 0;

    Item{
        focus:true;
        Keys.onPressed:
            switch(event.key){
            case Qt.Key_Left:
            case Qt.Key_Right:
                coca.x = coca.x +  (window.width /50);
                count_P1 ++ ;
                console.log("coca : " + coca.x  + "window : "+ window.width);

                if(coca.x >= (window.width - coca.width) ){
                    console.log("P1 win");
                }

                break;

            case Qt.Key_A :
            case Qt.Key_D:
                coca.x = coca.x - (window.width /50);
                count_P2 ++ ;
                console.log("coca : " + coca.x  + "window : "+ window.width);
                if(coca.x <= 0){
                    console.log("P2 win");
                }
                break;

            }
    }
}
