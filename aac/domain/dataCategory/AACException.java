/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.dataCategory;

/**
 *
 * @author Walker
 */
public class AACException extends Exception {

    /**
     * Creates a new instance of <code>AACException</code> without detail
     * message.
     */
    public AACException() {
    }

    /**
     * Constructs an instance of <code>AACException</code> with the specified
     * detail message.
     *
     * @param msg the detail message.
     */
    public AACException(String msg) {
        super(msg);

    }

    public AACException(String message, Throwable cause) {
        super(message, cause);
    }

}
