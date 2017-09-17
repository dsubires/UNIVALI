package app;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.table.DefaultTableModel;


public class InterfazCMC extends JFrame {


	private static final long serialVersionUID = 1L;
	private  String[] nombresColumnas;
	private  Object[][] datos;
	private  JTable jTable1;
	private  JPanel panel;
	private  JMenuBar menuBar;
	private JButton boton;
	private JButton boton2;
	private JTextArea textArea;
	String file = "";
	

	public InterfazCMC(){
		
	
		// creamos panel y añadimos elementos
		panel = new JPanel(new BorderLayout());
		DefaultTableModel tableModel = new DefaultTableModel(datos, nombresColumnas);
		jTable1 = new JTable(tableModel);


		
		menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		JMenu archivo= new JMenu("Archivo");
		JMenu ayuda= new JMenu ("Ayuda");
		
		menuBar.add(archivo);
		menuBar.add(ayuda);
		
		JMenuItem accionSalir = new JMenuItem("Salir");
		accionSalir.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		
		
		archivo.add(accionSalir);

		getContentPane().add(panel, BorderLayout.SOUTH);
		JScrollPane scrollPane = new JScrollPane(jTable1);
		getContentPane().add(scrollPane, BorderLayout.CENTER);
		
		
		
		boton = new JButton("Executar");
		boton2 = new JButton("Escolha o Arquivo");
		
		add(boton,BorderLayout.AFTER_LAST_LINE);
		add(boton2,BorderLayout.BEFORE_FIRST_LINE);
		
		textArea = new JTextArea("");

		 add(textArea);
		 
	     JScrollPane scroll = new JScrollPane(textArea);
	     add(scroll);

		 
		boton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evento) {

	               
	            textArea.append(CalculateMIPSCycles.calculate(file));
                }
        });   
		
		boton2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evento) {
                    JFileChooser elegir = new JFileChooser();
                    int opcion = elegir.showOpenDialog(boton);
               
                    //Si presionamos el boton ABRIR en pathArchivo obtenemos el path del archivo
                    if (opcion == JFileChooser.APPROVE_OPTION) 
                    	file = elegir.getSelectedFile().getPath();
                }
        });   
		
		
	}
	
	public static void main(String[] args) {
		InterfazCMC frame = new InterfazCMC();
		frame.setDefaultCloseOperation(3);
		frame.setTitle("InterfazCMC");
		frame.setSize(500, 400);
		frame.setResizable(false);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);
	}

}
;
