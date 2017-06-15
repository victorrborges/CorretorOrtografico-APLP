#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include <sstream>

using namespace std;

vector <string> dicionario;
vector <string> palavrasDoTexto;
string texto;

void setup();
void dividirTexto();
bool pertenceAoDicionario(string palavra);
void varrerPalavras();
void corrigirTexto();
void menuPrincipal();
void menuCorrecao(string palavra);
void corrigir(string palavra);
void palavrasParecidas(string palavra);
void adicionar(string palavra);
bool primeiraVerificacao(string palavra, string palavraDoDicionario);
bool segundaVerificacao(string palavra, string palavraDoDicionario);


int main () {
	setup();
	menuPrincipal();
	return (0);
}

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

vector<string> split(string str, char delimiter) {
  vector<string> internal;
  stringstream ss(str); // Turn the string into a stream.
  string tok;

  while(getline(ss, tok, delimiter)) {
    internal.push_back(tok);
  }

  return internal;
}

void dividirTexto() {

	palavrasDoTexto = split(texto, ' ');


}

bool pertenceAoDicionario(string palavra) {
	for (int i = 0; i < dicionario.size(); i++) {
		if(palavra == dicionario[i]) {
			return true;
		}
	}
	return false;
}

void varrerPalavras() {

	dividirTexto();

	for(int i = 0; i < palavrasDoTexto.size(); i++) {
		if(!pertenceAoDicionario(palavrasDoTexto[i])) {
			menuCorrecao(palavrasDoTexto[i]);
		}
	}

	cout << "" << endl
			 << "=======> Texto após correção: ";
	for (int i = 0; i < palavrasDoTexto.size(); i++) {
		cout << palavrasDoTexto[i] + " ";
	}

	cout << "" << endl;

}

void corrigirTexto() {
	cout << "" << endl
			 << "CORREÇÃO DE TEXTOS" << endl
	     << "" << endl
			 << "Digite o texto que você deseja corrigir: " << endl;
	getline (cin,texto);
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


void menuCorrecao(string palavra) {
	int option;
	// O print deve adicionar a palavra errada referente	
	cout << "" << endl
			 << "Palavra errada ----> " << palavra << endl
			 << "1 - CORRIGIR" << endl
			 << "2 - ADICIONAR" << endl
			 << "3 - IGNORAR" << endl << endl
			 << "Escolha opção:" << endl;

			cin >> option;
	 		cin.ignore();

	 		switch (option) {

	 			case 1:
	 				corrigir(palavra);
	 				break;
	 			case 2:
	 				adicionar(palavra);
	 				break;
				case 3:
					break;
	 			default:
	 				cout << "Opção inválida" << endl;
	 				break;

	 		}
}

bool primeiraVerificacao(string palavra, string palavraDoDicionario) {
	int diferencaDeTamanho = fabs(palavra.length() - palavraDoDicionario.length());
	int letrasErradas = 0;
	int palavra1 = palavra.length();
	int palavra2 = palavraDoDicionario.length();
	int count;
	if(diferencaDeTamanho > 2) {
		return false;	
	}

	if (palavra1 > palavra2) {
		count = palavra1;
	} else {
		count = palavra2;
	}

	for (int i = 0; i < count; i++) {
		if(palavra[i] != palavraDoDicionario[i]) {
			letrasErradas++;
		}
	}
	if(letrasErradas > 2) {
		return false;
	} else {
		return true;
	}
}

bool segundaVerificacao(string palavra, string palavraDoDicionario) {
	sort(palavra.begin(), palavra.end());
	sort(palavraDoDicionario.begin(), palavraDoDicionario.end());
	if(palavra == palavraDoDicionario) {
		return true;
	} else {
		return false;
	}

}

void corrigir(string palavra) {
	palavrasParecidas(palavra);
}

void palavrasParecidas(string palavra) {
	vector <string> parecidas;

	for (int i = 0; i < dicionario.size(); i++) {
		if(primeiraVerificacao(palavra, dicionario[i]) || segundaVerificacao(palavra, dicionario[i])) {
			parecidas.push_back(dicionario[i]);
		}
	}

	if (parecidas.size() == 0) {
		cout <<"Não há sugestões. Escolha outra opção."<< endl;
		menuCorrecao(palavra);
		return;
	}

	int index = 1;
	for (int i = 0; i < parecidas.size(); i++) {
		cout << index <<". "<< parecidas[i]<< endl;
		index++;
	}

	int option;

	cin >> option;
	cin.ignore();

	replace(palavrasDoTexto.begin(), palavrasDoTexto.end(), palavra, parecidas[option-1]);


}

void adicionar(string palavra) {
	dicionario.push_back(palavra);
}
