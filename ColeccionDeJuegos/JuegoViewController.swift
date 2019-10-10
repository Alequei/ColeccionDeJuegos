//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Alexander on 10/10/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var JuegoImageView: UIImageView!
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePiker = UIImagePickerController()
    var juego : Juegos? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePiker.delegate = self
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePiker.sourceType = .photoLibrary
        present(imagePiker, animated:  true, completion: nil)
        
    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info [UIImagePickerController.InfoKey.originalImage] as! UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePiker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }

    @IBAction func agregarTapped(_ sender: Any) {
        
        if (juego != nil){
            juego!.titulo=tituloTextField.text
            juego!.imagen = JuegoImageView.image!.pngData() as  Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juegos(context : context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image!.pngData() as Data?
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    
}


