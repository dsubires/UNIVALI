package app;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;

public class CalculateMIPSCycles {
	
	public static String calculate(String file){
		
		File archivo = null;
		FileReader fr = null;
		BufferedReader br = null;
		ArrayList<String> array = new ArrayList<String>();
		int nTotal = 0; // numero total de instrucoes
		int nI = 0; 
		int nJ = 0; 
		int nR = 0; 
		int nRE = 0; 
		int nB = 0; 
		int nL = 0; 
		int nS = 0; 
		int nCiclos = 0; // numero total de ciclos
		String output = ""; // saida do programa

		
		
		try {
			// criacao do archivo e do BufferedReader para poder
			// fazer leitura.
			archivo = new File(file);
			fr = new FileReader(archivo);
			br = new BufferedReader(fr);

			// leitura do arquivo
			String linea;
			while ((linea = br.readLine()) != null) {
				// pegamos os 2 primeiros caracters da instrucao em hexadecimal e convertemos para binario
				String opcode = hexToBinary(linea.substring(0, 2));

				// 2 digitos em hexadecimal sao 8 em binario
				// por isso sao retirados os 2 ultimos digitos do binario.
				// alem disso, fazemos com que a variavel tenha 6 caracters
				// ex:
				// ao pasar 00 de hexadecimal para binario, Java retorna 0, mas
				// precisamos que seja 000000
				// para resolver isso adicionamos 0 na esquerda o tanto quando necessario
				String zero = "0";
				while (opcode.length() < 8) {
					opcode = zero.concat(opcode);
				}
				array.add(opcode.substring(0, 6));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// fechamento do arquivo
			try {
				if (null != fr) {
					fr.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		// salvamos o número de instrucoes
		nTotal = array.size();

		// percorremos o array, identificamos o tipo de instrucao e
		// atualizamos o seu devido contador

		for (String opcode : array) {
			switch (opcode) {
			case "000000":
				nR++;
				break;
			case "000010":
				nJ++;
				break;
			case "000011":
				nJ++;
				break;
			case "000100":
				nB++;
				break;
			case "000101":
				nB++;
				break;
			case "001111":
				nL++;
				break;
			case "010111":
				nL++;
				break;
			case "011000":
				nL++;
				break;
			case "011001":
				nL++;
				break;
			case "101011":
				nS++;
				break;
			case "101100":
				nS++;
				break;
			case "101101":
				nS++;
				break;
			case "010001":
				nRE++;
				break;
			default:
				nI++;
				break;
			}

		}

		// multiplicamos o numero de ciclos de cada tipo pelo contador de
		// instrucoes de cada tipo
		nCiclos = 4 * nR + 3 * nJ + 4 * nI + 3 * nB + 5 * nL + 4 * nS;
		// mostramos todas as informacoes
		output += 
				output += "O programa tem um total de: " + nTotal + " instrucoes.\n";
				output += "O programa necessitara de " + nCiclos + " ciclos de clock.\n";
				output += "O número de ciclos por instrucao e: " + ( ((double)nCiclos / (double)nTotal))+"\n";
				output += "*****************\n";
				output += nJ + nB + " instrucoes com 3 ciclos\n";
				output += nR + nRE + nI + nS + " instrucoes com 4 ciclos\n";
				output += nL + " instrucoes com 5 ciclos\n";
		return output;
	}
	
	// esta funcao recebe como argumento um codigo hexadecimal, transforma em binario e devolve o resultado
	private static String hexToBinary(String hex) {
		int i = Integer.parseInt(hex, 16);
		String bin = Integer.toBinaryString(i);
		return bin;
	}

}
