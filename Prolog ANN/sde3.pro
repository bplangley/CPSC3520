



hop11Activation(Net, Alpha, _, Output):- Net>Alpha, Output is 1.0.
hop11Activation(Net, Alpha, Oldo, Output):- Net=Alpha, Output is Oldo.
hop11Activation(Net, Alpha, _, Output):- Net<Alpha, Output is -1.0.



netUnit([InH | InT],[WH | WT],Net):- netUnit(InT,WT,I), Net is (InH * WH)+I.
netUnit([],[],Net):- Net is 0.0.


netAll(_,[],[]).
netAll(State, [WeightsH | WeightsT], [NetH | NetT]):- netUnit(State,WeightsH, NetH), netAll(State,WeightsT, NetT).

trainHelper(_, [],_,_,[]).
trainHelper(X, [_ | ST], Row, Col,[WeightsH | WeightsT]) :- Row=Col, WeightsH is 0.0, trainHelper(X,ST,Row,Col+1,WeightsT).
trainHelper(X, [SH | ST], Row, Col,[WeightsH | WeightsT]):- WeightsH is (X * SH), trainHelper(X,ST,Row,Col+1,WeightsT).

train2([],_,_,_,[]).
train2([XH|XT],State,Row,Col,[WH |WT]):-trainHelper(XH, State, Row, Col, WH),train2(XT,State,Row+1,Col, WT).
hopTrainAstate(State, Weights):- train2(State,State,0.0,0.0, Weights).


addMatrix([AH |AT],[BH | BT], [SumH | SumT]):- addVec(AH,BH,SumH), addMatrix(AT,BT,SumT).
addMatrix(A,[],A).
addMatrix([],[],[]).

addVec([AH | AT],[BH |BT], [SumH | SumT]):- SumH is AH + BH, addVec(AT, BT, SumT).
addVec([],[],[]).

hopTrain([StlH | StlT], WM):-hopTrainAstate(StlH, Temp), hopTrain(StlT,Temp2), addMatrix(Temp,Temp2,WM).
hopTrain([],[]).


nextHelp(State,[WH |WT],Alpha, [RH | RT]):- netUnit(State,WH,RH), nextHelp(State, WT, Alpha,RT).
nextHelp(_,[],_,[]).
squash([TH|TT],Alpha,[SH|ST], [NextH | NextT]):-hop11Activation(TH,Alpha,SH,NextH),squash(TT,Alpha,ST,NextT).
squash([],_,[],[]).
nextState(State,W,Alpha,Next):-nextHelp(State,W,Alpha,Temp),squash(Temp,Alpha,State,Next).

nextState(_,[],[]).

updateN(State, _, _, N, State):-N=:=0.0.
updateN(State, WM, Alpha, N, RS):-N>0, nextState(State, WM, Alpha, TempState), updateN(TempState, WM, Alpha, N-1, RS).

