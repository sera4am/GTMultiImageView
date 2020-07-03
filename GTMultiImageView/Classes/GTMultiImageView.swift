//
//  GTMultiImageView.swift
//  GTMultiImageView
//
//  Created by 風間剛男 on 2020/07/02.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

public protocol GTMultiImageViewDelegate {
    func GTMultiImage(onLoad gtMultiImageView:GTMultiImageView)
    func GTMultiImage(onClick gtMultiImageView:GTMultiImageView, image:UIImage, index:Int)
}

public extension GTMultiImageViewDelegate {
    func GTMultiImage(onLoad gtMultiImageView:GTMultiImageView) {}
    func GTMultiImage(onClick gtMultiImageView:GTMultiImageView, image:UIImage, index:Int) {}
}

@IBDesignable
open class GTMultiImageView: UIView {

    open var delegate:GTMultiImageViewDelegate? = nil
    private let contentView:UIView = UIView()

    open var images:[UIImage] = [] {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable open override var backgroundColor: UIColor? {
        get { return contentView.backgroundColor }
        set { contentView.backgroundColor = newValue }
    }
    @IBInspectable open var cornerRadius:CGFloat {
        get { return contentView.layer.cornerRadius }
        set { contentView.layer.cornerRadius = newValue }
    }
    @IBInspectable open var borderWidth:Float {
        get { return Float(contentView.layer.borderWidth) }
        set { contentView.layer.borderWidth = CGFloat(newValue) }
    }
    @IBInspectable open var borderColor:UIColor? {
        get {
            if contentView.layer.borderColor == nil { return nil }
            return UIColor(cgColor: contentView.layer.borderColor!)
        }
        set { contentView.layer.borderColor = newValue?.cgColor }
    }
    @IBInspectable open var shadowOpacity:Float {
        get { return contentView.layer.shadowOpacity }
        set { contentView.layer.shadowOpacity = newValue }
    }
    @IBInspectable open var shadowColor:UIColor? {
        get {
            if contentView.layer.shadowColor == nil { return nil }
            return UIColor(cgColor: contentView.layer.shadowColor!)
        }
        set { contentView.layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable open var shadowOffset:CGSize {
        get { return contentView.layer.shadowOffset }
        set { contentView.layer.shadowOffset = newValue }
    }
    @IBInspectable open var shadowRadius:Float {
        get { return Float(contentView.layer.shadowRadius) }
        set { contentView.layer.shadowRadius = CGFloat(newValue) }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initView() {
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
    }
    
    open func clear() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
    
    private func updateView() {
        
        DispatchQueue.main.async {
            self.clear()
            
            if self.images.count == 0 { return }
            
            switch self.images.count {
            case 1:
                let iv = self.getImageView(self.images.first!)
                self.contentView.addSubview(iv)
                NSLayoutConstraint.activate([
                    iv.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: iv.bottomAnchor),
                    iv.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    self.contentView.trailingAnchor.constraint(equalTo: iv.trailingAnchor),
                ])
                break
            case 2:
                let iv1 = self.getImageView(self.images.first!, 0)
                let iv2 = self.getImageView(self.images.last!, 1)
                self.contentView.addSubview(iv1)
                self.contentView.addSubview(iv2)
                
                NSLayoutConstraint.activate([
                    iv1.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: iv1.bottomAnchor),
                    iv1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    iv2.leadingAnchor.constraint(equalTo: iv1.trailingAnchor, constant: 1),
                    iv2.widthAnchor.constraint(equalTo: iv1.widthAnchor, constant: 0),
                    self.contentView.trailingAnchor.constraint(equalTo: iv2.trailingAnchor),
                    iv2.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: iv2.bottomAnchor),
                ])
                break
            case 3:
                let iv1 = self.getImageView(self.images[0], 0)
                let iv2 = self.getImageView(self.images[1], 1)
                let iv3 = self.getImageView(self.images[2], 2)
                let v = UIView()
                v.translatesAutoresizingMaskIntoConstraints = false
                self.contentView.addSubview(iv1)
                self.contentView.addSubview(v)
                v.addSubview(iv2)
                v.addSubview(iv3)
                
                NSLayoutConstraint.activate([
                    iv1.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: iv1.bottomAnchor),
                    iv1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    v.leadingAnchor.constraint(equalTo: iv1.trailingAnchor, constant: 1),
                    v.widthAnchor.constraint(equalTo: iv1.widthAnchor, constant: 0),
                    self.contentView.trailingAnchor.constraint(equalTo: v.trailingAnchor),
                    v.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: v.bottomAnchor),
                    
                    iv2.topAnchor.constraint(equalTo: v.topAnchor),
                    iv2.leadingAnchor.constraint(equalTo: v.leadingAnchor),
                    v.trailingAnchor.constraint(equalTo: iv2.trailingAnchor),
                    iv3.topAnchor.constraint(equalTo: iv2.bottomAnchor, constant: 1),
                    iv3.leadingAnchor.constraint(equalTo: v.leadingAnchor),
                    v.trailingAnchor.constraint(equalTo: iv3.trailingAnchor),
                    v.bottomAnchor.constraint(equalTo: iv3.bottomAnchor),
                    iv3.heightAnchor.constraint(equalTo: iv2.heightAnchor, constant: 0),
                ])
                break
            case 4...:
                let iv1 = self.getImageView(self.images.first!, 0)
                let iv2 = self.getImageView(self.images[1], 1)
                let iv3 = self.getImageView(self.images[2], 2)
                let iv4 = self.getImageView(self.images[3], 3)
                let v1 = UIView()
                let v2 = UIView()
                let v4 = UIView()
                let vb4 = UIView()
                let l = UILabel()
                
                v1.translatesAutoresizingMaskIntoConstraints = false
                v2.translatesAutoresizingMaskIntoConstraints = false
                v4.translatesAutoresizingMaskIntoConstraints = false
                vb4.translatesAutoresizingMaskIntoConstraints = false
                l.translatesAutoresizingMaskIntoConstraints = false
                
                self.contentView.addSubview(v1)
                self.contentView.addSubview(v2)
                v1.addSubview(iv1)
                v1.addSubview(iv2)
                v2.addSubview(iv3)
                v2.addSubview(v4)
                v4.addSubview(iv4)
                v4.addSubview(vb4)
                vb4.addSubview(l)
                
                let white:UIColor = .white
                vb4.backgroundColor = white.withAlphaComponent(0.5)
                l.font = UIFont.boldSystemFont(ofSize: 18)
                l.textColor = .darkGray
                l.isUserInteractionEnabled = false
                vb4.isHidden = true
                vb4.isUserInteractionEnabled = false
                
                if self.images.count > 4 {
                    l.text = "+\(self.images.count - 4)"
                    vb4.isHidden = false
                }
                
                NSLayoutConstraint.activate([
                    v1.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: v1.bottomAnchor),
                    v1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    v2.leadingAnchor.constraint(equalTo: iv1.trailingAnchor, constant: 1),
                    v2.widthAnchor.constraint(equalTo: iv1.widthAnchor, constant: 0),
                    self.contentView.trailingAnchor.constraint(equalTo: v2.trailingAnchor),
                    v2.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    self.contentView.bottomAnchor.constraint(equalTo: v2.bottomAnchor),
                    
                    iv1.topAnchor.constraint(equalTo: v1.topAnchor),
                    iv1.leadingAnchor.constraint(equalTo: v1.leadingAnchor),
                    v1.trailingAnchor.constraint(equalTo: iv1.trailingAnchor),
                    iv2.topAnchor.constraint(equalTo: iv1.bottomAnchor, constant: 1),
                    iv2.leadingAnchor.constraint(equalTo: v1.leadingAnchor),
                    v1.trailingAnchor.constraint(equalTo: iv2.trailingAnchor),
                    v1.bottomAnchor.constraint(equalTo: iv2.bottomAnchor),
                    iv2.heightAnchor.constraint(equalTo: iv1.heightAnchor, constant: 0),
                    
                    iv3.topAnchor.constraint(equalTo: v2.topAnchor),
                    iv3.leadingAnchor.constraint(equalTo: v2.leadingAnchor),
                    v2.trailingAnchor.constraint(equalTo: iv3.trailingAnchor),
                    v4.topAnchor.constraint(equalTo: iv3.bottomAnchor, constant: 1),
                    v4.leadingAnchor.constraint(equalTo: v2.leadingAnchor),
                    v2.trailingAnchor.constraint(equalTo: v4.trailingAnchor),
                    v2.bottomAnchor.constraint(equalTo: v4.bottomAnchor),
                    v4.heightAnchor.constraint(equalTo: iv3.heightAnchor, constant: 0),

                    iv4.topAnchor.constraint(equalTo: v4.topAnchor),
                    v4.bottomAnchor.constraint(equalTo: iv4.bottomAnchor),
                    iv4.leadingAnchor.constraint(equalTo: v4.leadingAnchor),
                    v4.trailingAnchor.constraint(equalTo: iv4.trailingAnchor),
                    
                    vb4.topAnchor.constraint(equalTo: v4.topAnchor),
                    v4.bottomAnchor.constraint(equalTo: vb4.bottomAnchor),
                    vb4.leadingAnchor.constraint(equalTo: v4.leadingAnchor),
                    v4.trailingAnchor.constraint(equalTo: vb4.trailingAnchor),
                    
                    l.centerXAnchor.constraint(equalTo: vb4.centerXAnchor),
                    l.centerYAnchor.constraint(equalTo: vb4.centerYAnchor),
                    
                ])
                
                v4.bringSubviewToFront(vb4)
                
                break
            default:
                break
            }
            
            self.delegate?.GTMultiImage(onLoad: self)
        }
        

        
    }
    
    @objc func onImageTapped(_ sender:Any?) {
        guard let b = sender as? UIButton else { return }
        delegate?.GTMultiImage(onClick: self, image: images[b.tag], index: b.tag)
    }
    
    private func getImageView(_ image:UIImage, _ tag:Int = 0) -> UIView {
        let v:UIView = UIView()
        let b:UIButton = UIButton()
        let i:UIImageView = UIImageView()
        i.tag = tag
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = image
        i.clipsToBounds = true
        let c = UIColor.white
        b.backgroundColor = c.withAlphaComponent(0.0001)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = tag
        b.addTarget(self, action: #selector(onImageTapped(_:)), for: .touchUpInside)
        v.addSubview(i)
        v.addSubview(b)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            i.topAnchor.constraint(equalTo: v.topAnchor),
            v.bottomAnchor.constraint(equalTo: i.bottomAnchor),
            i.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: i.trailingAnchor),
            
            b.topAnchor.constraint(equalTo: v.topAnchor),
            v.bottomAnchor.constraint(equalTo: b.bottomAnchor),
            b.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: b.trailingAnchor),
        ])
        v.bringSubviewToFront(b)
        v.clipsToBounds = true
        
        return v
    }
    
    private var parentViewController: UIViewController? {
        get {
            var parentResponder: UIResponder? = self
            while true {
                guard let nextResponder = parentResponder?.next else { return nil }
                if let viewController = nextResponder as? UIViewController {
                    return viewController
                }
                parentResponder = nextResponder
            }
        }
    }
}
