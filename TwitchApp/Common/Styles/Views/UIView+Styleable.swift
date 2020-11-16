//
//  UIView+Styleable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

private var associateKey: Void?
private var styleAssociateKey: Void?

extension UIView: Styleable {
    @IBInspectable
    var styleName: String? {
        get { objc_getAssociatedObject(self, &associateKey) as? String }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

            guard let styleName = newValue else { return }
            guard !styleName.isBlank else { return }
            guard let style = StylesManager.shared.style(forName: styleName) else { return }

            self.style = style
        }
    }

    var style: Style? {
        get { objc_getAssociatedObject(self, &styleAssociateKey) as? Style }
        set {
            objc_setAssociatedObject(self, &styleAssociateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

            applyStyle()
            sizeToFit()
        }
    }

    private var boundsValueObserver: NSKeyValueObservation? {
        get { objc_getAssociatedObject(self, &associateKey) as? NSKeyValueObservation }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    @objc func applyStyle() {
        if boundsValueObserver == nil {
            boundsValueObserver = self.layer.observe(\.bounds) { [weak self] _, _ in
                self?.applyLayersStyle()
            }
        }

        applyLayersStyle()
    }

    // This is override of background color implementation
    // To get/set base color we can't use same getter/setter 'cause there is no way to call super backgroundColor
    // So to workaround it we can get/set super backgroundColor via value(forKey: ) & setValue(_, forKey: )
    var backgroundColor: UIColor? {
        get {
            if style != nil, let layer = layer.sublayers?[0] as? CAShapeLayer {
                return layer.fillColor?.let { UIColor(cgColor: $0) }
            } else {
                return value(forKey: "backgroundColor") as? UIColor
            }
        }
        set {
            if style != nil, let layer = layer.sublayers?[0] as? CAShapeLayer {
                layer.fillColor = newValue?.cgColor
            } else {
                setValue(newValue, forKey: "backgroundColor")
            }
        }
    }

    private func applyLayersStyle() {
        guard let viewStyle = style as? ViewStyle else { return }

        let borderLayer = sublayer(byName: "borderLayer")

        let drawingLayer = sublayer(byName: "drawingLayer")

        viewStyle.alpha?.let { [weak self] in
            self?.alpha = $0
        }

        viewStyle.tintColor?.let {
            [weak self] in self?.tintColor = $0
        }

        var cornerRadius: CGFloat = 0

        switch viewStyle.cornerRadius {
        case nil: break
        case .with(let radius):
            cornerRadius = radius
        case .roundedByHeight:
            cornerRadius = self.frame.height / 2.0
        case .roundedByWidth:
            cornerRadius = self.frame.width / 2.0
        }

        var path = UIBezierPath(rect: bounds)
        if viewStyle.cornerRadius != nil {
            path = UIBezierPath(
                    roundedRect: bounds,
                    cornerRadius: cornerRadius
            )
        }
        drawingLayer.path = path.cgPath

        drawingLayer.fillColor = viewStyle.backgroundColor?.cgColor ?? UIColor.clear.cgColor

        if let shadow = viewStyle.shadow {
            drawingLayer.shadowColor = shadow.color.cgColor
            drawingLayer.shadowPath = drawingLayer.path
            drawingLayer.shadowOffset = shadow.offset
            drawingLayer.shadowOpacity = shadow.opacity
            drawingLayer.shadowRadius = shadow.radius
        }

        if let stroke = viewStyle.stroke {

            let insetBounds = bounds.insetBy(dx: stroke.width / 2, dy: stroke.width / 2)
            var path = UIBezierPath(rect: insetBounds)
            if viewStyle.cornerRadius != nil {
                path = UIBezierPath(
                        roundedRect: insetBounds,
                        cornerRadius: cornerRadius
                )
            }

            borderLayer.path = path.cgPath
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = stroke.color.cgColor
            borderLayer.lineWidth = stroke.width
        }
    }

    private func sublayer(byName name: String) -> CAShapeLayer {
        if let subLayer = layer.sublayers?.first(where: { $0 is CAShapeLayer && $0.name == name }) as? CAShapeLayer {
            return subLayer
        } else {
            let subLayer = CAShapeLayer()
            subLayer.name = name
            self.layer.insertSublayer(subLayer, at: 0)
            return subLayer
        }
    }
}
