using UnityEngine;

public class CollectibleSphere : MonoBehaviour
{
    public Material shaderMaterial;  // Assign in Inspector
    private static int collectedCount = 0;
    private static int totalSpheres = 5;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            var renderers = other.GetComponentsInChildren<Renderer>();
            foreach (var rend in renderers)
            {
                rend.material = shaderMaterial;
            }

            Debug.Log("Collectible Sphere Collected");

            collectedCount++;
            Destroy(gameObject);

            if (collectedCount >= totalSpheres)
            {
                Debug.Log("Game Over! All spheres collected!");
            }
        }
    }

}
