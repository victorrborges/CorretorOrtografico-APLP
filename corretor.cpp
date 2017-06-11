#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

vector <string> dicionario;
vector <string> palavrasDoTexto;
string texto;

void setup() {
	
	cout << "" << endl
			 << "CORRETOR ORTOGRÁFICO!" << endl
			 << "" << endl
			 << "Primeiramente, iremos configurar o dicionário." << endl
	     << "Digite as palavras que você deseja incluir no dicionário: " << endl
	     << "obs: ao finalizar, digite \"end-dicionario\". " << endl;
	string entrada;
	while (entrada != "end-dicionario") {
		cin >> entrada;
		cin.ignore();
		dicionario.push_back(entrada);
	} 
	dicionario.pop_back();
}

void dividirTexto() {

	string delimiter = " ";

	size_t pos = 0;
	string token;
	while ((pos = texto.find(delimiter)) != std::string::npos) {
    		token = texto.substr(0, pos);
    		palavrasDoTexto.push_back(token);
    		texto.erase(0, pos + delimiter.length());
	}


}


void varrerPalavras() {

	dividirTexto();

	for(int i = 0; i < palavrasDoTexto.size(); i++) {
		bool correta = false;
			for(int j = 0; j < dicionario.size(); j++) {
				if (palavrasDoTexto[i] == dicionario[j]) {
					correta = true;
					break;
					
				} 

			}
		if (correta == false) {
			//Palavra nao esta correta, chamar o corrigirTexto

		}
	
	}

}


void corrigirTexto() {
	cout << "CORREÇÃO DE TEXTOS" << endl
	     << "" << endl
			 << "Digite o texto que você deseja corrigir: " << endl;
	//nao esta salvando a ultima palavra do texto	
	getline (cin,texto);
	// Chamar o varrerPalavras();
	varrerPalavras();
}

void menuPrincipal() {
	int option;

	while(option != 2) {

		cout << "" << endl
	     	<< "MENU PRINCIPAL" << endl
				 << "" << endl
	     	<< "Escolha uma Opção:" << endl
				 << "1 - Corrigir texto" << endl
				 << "2 - Finalizar o programa" << endl;
		cin >> option;
		cin.ignore();
	

		switch (option) {
	
			case 1:
				corrigirTexto();
				break;
			case 2:
				return;
				break; 
			default:
				cout << "Opção inválida" << endl;
				break;
	
		}
	}

}


void menuCorrecao() {
	// O print deve adicionar a palavra errada referente
	cout << "Palavra errada ----> " << endl << endl
			 << "1 - CORRIGIR" << endl
			 << "2 - ADICIONAR" << endl
			 << "3 - IGNORAR" << endl << endl
			 << "Escolha opção:" << endl;
}

void corrigir() {
	// Chamar o palavrasParecidas();
}

void palavrasParecidas() {
	// Listar as palaras parecidas e deixar o usuário escolher
}

void adicionar() {
	// Acrescentar a palavra no dicionario
}

int main () {
	setup();
	menuPrincipal();
	return (0);
}
